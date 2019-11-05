## Background
### Impetus

In the current implementation, we destroy the newly-created `WebContents` when the consumer calls `event.preventDefault()`. In recent Electron versions, this can cause a crash, because the WebContents is still initializing when we kill it. Additionally, the preload script has started to run, which has the potential to cause quite a bit of confusion for developers looking at logs. We could patch and continue to patch these weirdnesses, but fixing the root seems appropriate sooner rather than later.

### Future of window.open

As we align more with Chrome's process model, `BrowserWindowProxy` will become less necessary. `nativeWindowOpen: true` will become the default and the ergonomics (and durability) of this API will matter quite a bit more!

### Current API pain points

1. Returning a window via `event.newGuest` in the event handler is unprecedented in Electron and doesn't fit normal "Web Events" semantics
2. The `options` argument of `new-window` is a mix of parsed options from the feature string and important fields provided by Electron, like `webContents` itself. It's not clear that you need to pass `webContents` into the overridden window for things to work.
3. Can't set `webPreferences`, since the webContents was already created

### Use cases

1. Custom handling for target="_blank" links from trusted or untrusted content.
    - Canceling disallowed urls
    - Kicking out to a browser vs. opening windows with Electron
2. Opening application windows with synchronous DOM access
3. Navigating to external sites (for OAuth flows, for example)

### Platforms

All platforms

## Proposal

### Summary

At a high level, I propose we add an event, `will-create-child-web-contents`, so that we can cancel the renderer-initialized `WebContents` creation earlier than we do now. Additionally, for improved clarity and ergonomics, I suggest we change the name of the `WebContents`'s  `new-window` event to `will-create-child-window` and slightly change its mechanics. 

I would guess that most classes of app would need to subscribe to zero or one of these events. Only the most complex would need both (Slack! Teams!).

### API Design

#### `will-create-child-web-contents`

Addresses parts of **use case #1** wherein the consumer wants to stop a renderer's `window.open` call from succeeding.

**Note:** this will not fire for an iframe, a potential point of confusion.

**Possible implementation**

There are already delegate methods that we could hook into to emit this event before the `WebContents` is created, no patching necessary: `ShouldCreateWebContents` (7-0-x) and `IsWebContentsCreationOverridden` (master). 

**Example**

```javascript
mainWindow.webContents.on(
  'will-create-child-web-contents',
  (event, url, frameName, disposition, options, additionalFeatures) =>
{
  if (!url.match(MY_APP_REGEX)) event.preventDefault();
});
 ```

#### `will-create-child-window`

*Deprecates `WebContents`'s `new-window`*

Mostly the same as today's `new-window` event, this will address the need to customize the window for a renderer-created window, while polishing some of the semantics.

**Possible implementation**

To address **pain point #1**, we'll make use of `TrackableObject` to find the window that was bound to the `WebContents` passed to the event handler. For **pain point #2**, we can throw helpful errors: if the consumer has called `preventDefault` and not bound the `WebContents` to a window, throw an error. If the consumer has bound the `WebContents` to a new window without calling `preventDefault`, throw an error. **Pain point #3** remains unresolved.

**Example**

```javascript
mainWindow.webContents.on(
  'will-create-child-window',
  (event, url, frameName, disposition, options, additionalFeatures) =>
{
  event.preventDefault();
  const win = new BrowserWindow({ 
  	...options,
  	width: 100,
    height: 100
  });
  // We want the new API to continue to allow access to the new window, such that 
  // handlers can be attached, for example.
  myApp.monitorWindowEvents(win);`
});
```

### Naming

I am open to adjusting the event names to strike the right balance of clarity and concision. In choosing these names, I was aiming toward a few goals:

1. Suggest *where* the event is happening

    While the event namespace, `webContents`, does suggest that the window is being created from the renderer, that connection isn't necessarily clear to beginners. Including "child" in the event contextualizes the event for web-minded individuals, while still being technically supported.

2. Suggest that the events can be cancelled / overridden with "will."
3. Add a verb to better match the other `webContents` event names.

### Rollout plan

*I'm not super familiar yet with the deprecation process in Electron — will yield to people who know better.*

Deprecate `new-window` with a console warning and introduce the new events in 7.2.0 and 8.0.0

Remove `new-window` in 9.0.0
