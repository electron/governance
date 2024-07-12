# Views API (Part 1): Support Setting Content View

## Summary

This spec proposes to make parts of `views` related APIs public, which should be
enough to implement a simple splash screen for apps.

(`views` is the name of Chromium's UI library.)

## Platforms

All.

## Impetus

I would like to extend Electron's APIs to provide ability to build native UI,
but it would too much work to do it all at once. So I plan to do it piece by
piece, and with each addition the apps should be able to do something that was
impossible before.

With this spec, users would be able to change the content view of windows. One
possible use is to show a splash image when the app is loading, and change the
splash image to WebContents after loading is finished.

```js
const {app, nativeImage, webContents, ImageView, TopLevelWindow, WebContentsView} = require('electron')

app.once('ready', () => {
  const win = new TopLevelWindow({})
  const imageView = new ImageView()
  imageView.setImage(__dirname + '/splash.png')
  win.setContentView(imageView)

  const web = new WebContentsView({})
  web.webContents.once('did-finish-load', () => win.setContentView(web))
  web.webContents.loadURL('https://github.com/')
})

app.on('window-all-closed', () => {
  app.quit()
})
```

## API Design

There are several new APIs in this spec, most of them are actually internal
APIs that already being used. The main work would be documenting them and making
them public.

### `TopLevelWindow`

The `TopLevelWindow` class represents a native window, which implements all
window related APIs and has an empty content view.

The `BrowserWindow` class inherits from `TopLevelWindow` and uses
`WebContentsView` as its content view.

### `TopLevelWindow.setContentView(view)`

This changes the content view of the window.

The `view` is an instance of `View` class, with this spec there will be 2 types
of `View`: `WebContentsView` and `ImageView`, and they inherit from the `View`
class.

### `TopLevelWindow.getContentView()`

Returns the content view of the window. For `BrowserWindow` it would be a
`WebContentsView`.

### `View`

The base class for native UI elements. In following specs I will add ability to
add child views, in this spec it does not have any ability.

### `ImageView`

A native UI element that displays image.

Currently it only displays static image, an we may want to add ability to
display GIF animations in future.

### `WebContentsView`

A native UI element that displays the content of `WebContents`.

### `new WebContentsView(webPreferences)`

Create an instance of `WebContentsView` class, the `webPreferences` is the same
options that passed to `BrowserWindow`.

### `WebContentsView.webContents`

Returns the WebContents hosted by this view.

## Rollout Plan

This will live in Electron `v10.0.0` and beyond.
