# Renderer Scripts

## Summary
Renderer scripts provide an isolated V8 context to interact with the renderer process. A reworked contextBridge API provides safe access to Worker and Worklet contexts from renderer scripts.

## Platforms
All

## Impetus
<!--- What is prompting this change? A bug, user feedback, or something else? If there is a bug, please link it. --->
Worker and worklet contexts are underserved by Electron's preload scripts API. No infrastructure exists within Electron/Chromium to safely interact with these contexts (like Chrome's [content scripts](https://developer.chrome.com/docs/extensions/mv3/content_scripts/)).

`nodeIntegrationInWorker` provides the ability to inject Node into worker contexts, but only in non-sandboxed environments ([#28620](https://github.com/electron/electron/issues/28620)) which isn't viable for secure applications. Preloads in workers was attempted previously ([#28923](https://github.com/electron/electron/pull/28923)), but did not meet Electron's secure-by-default policy.

Worklets provide unknown or limited support with the `nodeIntegrationInWorker` option and have documented issues ([#22503](https://github.com/electron/electron/issues/22503)).

This proposal introduces the concept of a Renderer Script which is a separate isolated context tied to a renderer process. Worker or worklet creation would emit new events in this context.

`contextBridge` provides a safe way to expose APIs within a remote context—currently only used for preload contexts in render frames. To safely expose APIs within a worker or worklet context, `contextBridge` could be reworked to allow usage from renderer scripts.

## API Design
<!--- Discuss any background and motivation not already in the summary above. Give implementation details. What options are under consideration, and what is your preferred solution or approach? --->

Renderer scripts would provide an implementation similar to preload scripts. Configuration within the main process would be possible via `Session` instances.

```ts
// main process

interface RendererScriptInfo {
  path: string
}

interface Session {
  // Get/set renderer scripts similar to setPreloads/getPreloads
  setRendererScripts(scripts: Array<RendererScriptInfo>): void
  getRendererScripts(): Array<RendererScriptInfo>

  // Or would it be better just as an array? 🤔
  rendererScripts: Array<RendererScriptInfo>
}
```

Once a renderer process has been created, a new context would be created to run our renderer scripts. A new `renderer` API would be introduced which can be thought of as an `app` equivalent in the renderer process.

```ts
// renderer process

// import { renderer } from 'electron'
/**
 * Renderer emits events related to RenderFrames and contexts.
 */
interface Renderer {
  /** Emitted when a new script context is created for a render frame. */
  on('script-context-created', (details: { context: Context })): void

  /** Emitted on document start in a render frame. */
  on('document-start', (details: { frame: WebFrame, context: Context })): void

  /** Emitted on document end in a render frame. */
  on('document-end', (details: { frame: WebFrame, context: Context })): void

  /** Emitted before evaluating a service worker context. */
  on('will-evaluate-service-worker', (details: { context: Context })): void
}

/**
 * Context is an abstraction of a V8 context which provides additional
 * metadata and the ability to execute arbitrary scripts.
 */
interface Context {
  type: 'main' | 'isolated' | 'worker' | 'worklet'
  worldId: number
  executeJavaScript(code: string, userGesture?: boolean): Promise<any>
}

// import { contextBridge } from 'electron'
/**
 * contextBridge is reworked to provide instances from Contexts.
 *
 * In addition to Isolated World -> Main World, we now have:
 *  Renderer Script -> Main World
 *  Renderer Script -> Isolated World
 *  Renderer Script -> Worker World
 *  Renderer Script -> Worklet World
 */
interface contextBridge {
  static from(context: Context): ContextBridge
}

interface ContextBridge {
  /** Rename 'exposeInMainWorld' to be generic. */
  expose(apiKey: string, api: any): void
}
```

#### Additional considerations

- Should renderer scripts be implemented for both sandboxed and non-sandboxed renderers?
  - Is deprecation planned for non-sandboxed renderers eventually?
- Renderer process has two threads: main and worker
  - A renderer context might need to be created in each thread to have access
    to worker contexts.
  - Should renderer scripts be assigned to one or both?
    ```ts
    session.setRendererScripts([
      { code: 'foo', thread: 'main' },
      { code: 'bar', thread: 'worker' },
      { code: 'baz' } // default to main thread
    ]) 
    ```
- `ipcRenderer` is tightly coupled to `RenderFrame`. Need to consider how to make it
  work with renderer scripts in the renderer process.
- Debugging the renderer script context with DevTools requires creating a new
  `content::DevToolsAgentHostImpl` subclass.
- The `Context` interface is similar enough to `ContextBridge`. It might make sense to
  deprecate `ContextBridge` in favor of just `Context` which could offer an `expose(apiKey, api)`
  method.

### Usage examples
<!-- Give concrete examples of how this API will be used. -->

#### Service worker context access

Listen for context creation in renderer scripts, then create a `ContextBridge` instance
to expose custom APIs. This concept could apply for any context created in the renderer
process.

```ts
// renderer.ts
import { renderer, ipcRenderer } from 'electron'

// content::RendererClient::WillEvaluateServiceWorkerOnWorkerThread()
renderer.on('will-evaluate-service-worker', ({ context }) => {
  const result = context.executeScript('globalThis.scope');

  // Expose custom API in service worker context
  const bridge = contextBridge.from(context);
  bridge.expose('api', {
    async getMainProcessData() {
      return await ipcRenderer.invoke('get-data');
    }
  });
});
```

#### Preload scripts

With renderer scripts, it might be possible to fully recreate the preload scripts API
by reacting to events. Eventually we could move our C++ implementation into JS.


```ts
// renderer.ts
import { renderer } from 'electron'

const preloads = [
  { code: 'document.body.backgroundColor = "red"' }
];

renderer.on('document-start', ({ frame }) => {
  preloads.forEach((preload, i) => {
    const worldId = 1000 + i;
    frame.executeJavaScriptInIsolatedWorld(worldId, preload);
  })
});
```

## Rollout Plan
<!--- What branches do you ultimately want this API to live in? If this change would require a minor release, please justify the reason for that request. -->

* Add initial implementation
  - New V8 context created in each renderer thread
  - Renderer scripts forwarded from main process
  - Renderer events emitted from `renderer` API
  - ContextBridge reworked
  - Only for sandboxed renderers?
* Release renderer scripts API including documentation marked as experimental
* Rewrite preload scripts on top of internal renderer script?
