# Enhance Preload Scripts API

## Summary
Electron preload scripts work well when loaded into a top level frame. However, their support for loading in sub-frames or service workers is either subpar or non-existent. This proposal aims to enhance the preload scripts API to better support such use cases.

## Platforms
All.

## Impetus
<!--- What is prompting this change? A bug, user feedback, or something else? If there is a bug, please link it. --->
1. To add a preload script to subframes, setting `webPreferences.nodeIntegrationInSubFrames` is required. This has several shortcomings:
    - Not semantically intuitive. Node integration is not directly related to preloads.
      - [electron/electron#22582](https://github.com/electron/electron/issues/22582)
    - All or nothing. Can't opt-in to running in sub frames per preload script.
    - Planned [deprecation of `nodeIntegration`](https://github.com/electron/electron/issues/23506) flags?

2. Preloads are unable to be run within a service worker context.

3. Preloads are added for all URLs. For preloads which need to be added conditionally, this will slow down load times. Any web browsers built on Electron will likely run into this.

4. As more Electron security preferences are changed to be enabled by default, developers will increasingly need to rely on preloads to expose APIs for JavaScript IPC bridges.

## API Design
<!--- Discuss any background and motivation not already in the summary above. Give implementation details. What options are under consideration, and what is your preferred solution or approach? --->

Preload scripts are currently loaded by providing their path. To enhance the API, an object with additional properties could be provided.

```ts
interface Session {
  // Modified methods to use PreloadScript object.
  setPreloads(preloads: PreloadScript[])
  getPreloads(): PreloadScript[]
}

/**
 * An object for describing the context in which a preload script should be
 * loaded.
 */
interface PreloadScript {
  /** File path for the preload script. */
  path: string

  /**
   * URLs to run the preload in.
   * Ignored in the case of service workers?
   * 
   * Uses match patterns as defined by Chrome extensions:
   * https://developer.chrome.com/extensions/match_patterns
   * 
   * Defaults to running in all URLs.
   * 
   * e.g. ['https://www.electronjs.org/*']
   */
  matches?: string[]

  /**
   * Resource types to support running the preload.
   * 
   * Defaults to ['main-frame'].
   */
  resources?: ResourceType[]
}

/** Types of resources a preload script can run in. */
type ResourceType =
  | 'main-frame'
  | 'sub-frame'
  | 'service-worker'
```

> Some inspiration comes from Chrome extension [content scripts](https://developer.chrome.com/extensions/content_scripts) as well as the [`addContentScripts`](https://developer.chrome.com/apps/tags/webview#method-addContentScripts) method provided by the extensions `<webview>` tag.

### Usage examples
<!-- Give concrete examples of how this API will be used. -->

[electron-chrome-extensions](https://github.com/samuelmaddock/electron-browser-shell/tree/master/packages/electron-chrome-extensions) is a package which extends support for Chrome extensions in Electron. It relies on preload scripts and has a few requirements which could be improved by these enhancements:
- Inject web component only into privileged URLs.
  ```ts
  session.defaultSession.setPreloads([
    {
      path: 'browser-action-component.js',
      matches: ['browser://webui.html'],
    }
  ])
  ```
- Inject `chrome.*` APIs only into extension background pages.
  ```ts
  session.defaultSession.setPreloads([
    {
      path: 'chrome-extensions.js',
      matches: ['chrome-extension://*/*'],
    }
  ])
  ```
- Inject `chrome.*` APIs into extension service workers—in preparation for Manifest V3.
  ```ts
  session.defaultSession.setPreloads([
    {
      path: 'chrome-extensions.js',
      resources: ['service-worker']
    }
  ])
  ```

### Implementation details

The current implementation of preload scripts is different depending on whether the renderer is sandboxed.

In a non-sandboxed renderer, preload script paths are loaded from command line arguments. Preload script files are synchronously loaded via `require('module')._load`.

In a sandboxed renderer, preload script paths are loaded from a synchronous IPC event which reads file content in the browser process.

Having two separate methods of loading preload scripts is not ideal and should perhaps be replaced with a new API provided to both the non-sandboxed and sandboxed renderers. This would also avoid any possible limits of passing preload configuration through command line arguments.

#### Chromium extension scripts

Chromium's extensions implementation of user scripts involves serializing properties into a shared memory region which then sends Mojo IPCs to the renderer process upon updating. This is implemented in [UserScriptLoader](https://source.chromium.org/chromium/chromium/src/+/master:extensions/browser/user_script_loader.cc).

Whether this approach would merit application in Electron has yet to be fully evaluated.

## Rollout Plan
<!--- What branches do you ultimately want this API to live in? If this change would require a minor release, please justify the reason for that request. -->

This proposal can target the latest `master` branch at the time a PR is proposed.

A deprecation notice would be provided when `Session.setPreloads` is called with only a path `string`. The path would then be converted to a `PreloadScript` object internally.

The `webPreferences.preload` option would follow a similar deprecation, but still allow for a `PreloadScript` object.
