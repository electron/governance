# Electron C APIs

## Summary

Similar to the [Node-API (also known as N-API) of Node.js](https://nodejs.org/api/n-api.html), the Electron C APIs is a set of C APIs providing access to Electron and Chromium’s resources, which can be used in Node.js native modules.

## Platforms

All

## Impetus

There are 2 reasons:

### Easier to add new APIs

The majority of Electron’s JavaScript APIs are about accessing native resources of the operating system; some of them could not be implemented as native modules because they need to interact with Electron and Chromium’s resources.

For example, the `TouchBar` and `inAppPurchase` APIs must live as built-in APIs because the JavaScript bindings must interact with internal `ElectronApplicationDelegate` and `ElectronNSWindowDelegate`, and there is no non-intrusive way doing that outside Electron.

With Electron C APIs we can make it possible to have those APIs as native modules. This can make Electron less bloating since we don't have to make every new API a built-in API , and for users who want to add a large set of new APIs they can now only request a few minimal C APIs in Electron and then implement anything they want in native modules.

### Reduce Electron forks

Some people may already know that the official releases of VS Code and Teams use custom builds instead of the offical one, this is because they have some modifications that can not be upstreamed (for example some hacks to the `<video>` tag). By exposing certain internal Chromium APIs as Electron C APIs, we can make those modifications live as native modules instead of having a custom build.

## API Design

__Note that this spec does not define any speicific API and the C APIs used in this spec are only for demonstration, the actual APIs should be discussed in follwoup PRs.__

The Electron C APIs should be very cheap: they only take minimal disk space, usually less than 100 bytes per API since they are just thin wrappers; and they have no runtime cost.

To use the Electron C APIs in native modules, users only need to include the related headers:

```c
#include <node_api.h>
#include <electron/version.h>
#include <electron/main/app.h>
#include <electron/main/base_window.h>
#include <electron/common/native_image.h>
#include <chromium/main/view.h>
#include <chromium/renderer/render_frame.h>

// Get the native window handle of Electron window.
NSWindow* window = electron_base_window_get_native_handle(object);
[window setToolbar:toolbar];

// Create native views.
electron_view_t view = electron_view_create();
electron_button_t button = electron_button_create("Title");
electron_view_add_child_view(view, button);
electron_window_set_content_view(window, view);
```

### Usage examples

Simple BrowserWindow methods:

```c
// Native module definition.
napi_value WindowSetRepresentedFilename(napi_callback_info info) {
  napi_value window = GetArg(info, 1);
  napi_value filename = GetArg(info, 2);
  NSWindow* handle = electron_window_get_native_handle(window);
  [handle setRepresentedFilename:NStrToNSString(filename)];
}
```

```js
// JavaScript usage.
const {windowSetRepresentedFilename} = require('mymodule');
const win = new BrowserWindow({});
windowSetRepresentedFilename(win, '/path/to/file');

// Replaces the builtin API.
win.setPresentedFilename('/path/to/file');
```

Native dialogs interacting with BrowserWindow:

```c
// Native module definition.
napi_value CreateAlert(napi_callback_info info) {
  NSAlert* alert = [[NSAlert alloc] init];
  return Wrap(alert);
}

napi_value ShowAlert(napi_callback_info info) {
  napi_value alert = GetArg(info, 1);
  napi_value window = GetArg(info, 2);
  NSAlert* alert = UnWrap(alert);
  NSWindow* handle = electron_window_get_native_handle(window);
  [alert beginSheetModalForWindow:handle];
}
```

```js
// JavaScript usage.
const {createAlert, showAlert} = require('mymodule');
const alert = createAlert();
showAlert(alert, win);

// Replaces the builtin API.
dialog.showMessageBox(win, {});
```

Native UI APIs:

```c
// Native module definition.
napi_value CreateButton(napi_callback_info info) {
  return Wrap(electron_button_create());
}

napi_value CreateView(napi_callback_info info) {
  return Wrap(electron_view_create());
}

napi_value CreateWebContentsView(napi_callback_info info) {
  electron_web_web_preferences_t options = ParseOptionsArg(info, 1);
  return Wrap(electron_web_contents_view_create(&options));
}

napi_value WindowSetContentView(napi_callback_info info) {
  napi_value arg1 = GetArg(info, 1);
  napi_value arg2 = GetArg(info, 2);
  electron_window_t window = UnWrap(arg1);
  electron_view_t view = UnWrap(arg2);
  electron_window_set_content_view(window, view);
}
```

```js
// JavaScript usage.
const {View, Button...} = require('mymodule');
const contentView = new View();

const toolbar = new View();
toolbar.setStyle({height: 30});
const back = new Button('Back');
const forward = new Button(forward);
const entry = new Entry();
entry.setStyle({flex: 1});
const go = new Button(go);
toolbar.addChildView(back, forward, entry, go);

const web = new WebContentsView({nodeIntegration: true});
web.setStyle({flex: 1});

container.addChildView(toolbar, web);
const win = new BaseWindow({});
setWindowContentView(win, container);
```

## Rollout Plan

Like JavaScript APIs, the C APIs are added by creating PRs or RFCs, and rolled out with the same schedule. For the early stage we do not promise API or ABI stability.
