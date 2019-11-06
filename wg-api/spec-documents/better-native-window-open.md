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

## API Design

**Instance method `webContents.setWindowOpenOverride(handler)`**

- `handler` Function
    - `windowOpenInfo` Object
        - `url` String
        - `frameName` String
        - `disposition` String
        - `parsedOptions` BrowserWindowConstructorOptions
        - `additionalFeatures` String[]

    Returns `Boolean | BrowserWindowConstructorOptions`

Allows consumers to control whether a window is created and, if it should be created, with which `BrowserWindow` options. Unlike the current implementation, it allows for setting `webPreferences` on child windows.

Returning `true` will result in the default behavior, a native window will be created and returned to the caller in the renderer. Returning `false` will prevent creation of the window and return `null` to the caller. Returning `BrowserWindowConstructorOptions` will result in the default behavior, but with the provided options used when initializing the `BrowserWindow`.

**Event `did-create-window`**

*Deprecates `WebContents`'s `new-window`*

Allows app developers to setup monitoring of newly-created windows.

While today's `new-window` event fires before window creation, `did-create-window` fires afterward — thus, it is not cancellable with `event.preventDefault()`. It will not be emitted if the handler passed to `setWindowOpenOverride` returns `false`.

- `window` BrowserWindow
- `windowOpenInfo` Object
    - `url` String
    - `frameName` String
    - `disposition` String
    - `parsedOptions` BrowserWindowConstructorOptions
    - `additionalFeatures` String[]

### **Example**

```javascript
mainWindow.webContents.setWindowOpenOverride((
  { url, frameName, disposition, parsedOptions, additionalFeatures }
) => {
  if (!url.match(MY_REGEX)) return false;
  
  return {
    ...parsedOptions,
    width: 100,
    height: 100,
    webPreferences: {
      preload: 'my-script.js'
    }
  }
});

mainWindow.webContents.on('did-create-window', (
  win,
  { url, frameName, disposition, parsedOptions, additionalFeatures }
) => {
  myApp.monitorWindowEvents(win);
});
```

### Rollout plan

*I'm not super familiar yet with the deprecation process in Electron — will yield to people who know better.*

Deprecate `new-window` with a console warning and introduce the new events in 7.2.0 and 8.0.0

Remove `new-window` in 9.0.0
