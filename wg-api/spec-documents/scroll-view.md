# Scroll View

## Summary

This spec proposes to add an experimental native ScrollView component to Electron.

## Platforms
* macOS 
* Windows
* Linux

## Impetus

It is currently not possible to add scrolling functionality around BrowserViews:

* Capture mouse / touch events
* Reposition BrowserViews accordingly

More details of the use-case and challenges related to workarounds: [#32751](https://github.com/electron/electron/issues/32751)

![ScrollView concept](https://user-images.githubusercontent.com/2891206/150981006-84fe796e-60bd-43c0-952d-831d1bfd9998.gif)

## Usage Example

```js
const { BrowserWindow, View, ScrollView, WebContentsView } = require("electron");

const window = new BrowserWindow({ width: 1000, height: 500 })

const scroll = new ScrollView()
scroll.setBounds({ width: 1000, height: 500 })

const scrollContent = new View()

const webContentsView1 = new WebContentsView({})
webContentsView1.setBounds({ width: 1000, height: 500 })
scrollContent.addChildView(webContentsView1)

const webContentsView2 = new WebContentsView({})
webContentsView2.setBounds({ width: 1000, height: 500, x: 1000 })
scrollContent.addChildView(webContentsView2)

scroll.setContentView(scrollContent);
scroll.setContentSize({ width: 2000, height: 500 })
win.addChildView(scroll)
```


## API Design

- `View` - The base class for native UI elements.
- `ImageView` - The native UI element that displays image.
- `WebContentsView` - The native UI element that displays the content of `WebContents`.
- `ScrollView` - The native UI element that make any View scrollable.

## View

The base class for native UI elements. The current implementation has the
ability to add child views. In this spec more abilities  are added.

Process: **Main**

`View` is an EventEmitter

### `new View()` _Experimental_

Creates the new view.

### Instance Methods

#### `view.setAutoResize(options)` _Experimental_

* `options` Object
  * `width` boolean (optional) - If `true`, the view's width will grow and shrink together
    with its parent. `false` by default.
  * `height` boolean (optional) - If `true`, the view's height will grow and shrink
    together with its parent. `false` by default.
  * `horizontal` boolean (optional) - If `true`, the view's x position and width will grow
    and shrink proportionally with its parent. `false` by default.
  * `vertical` boolean (optional) - If `true`, the view's y position and height will grow
    and shrink proportionally with its parent. `false` by default.

#### `view.setBounds(bounds)` _Experimental_

Resizes and moves the view to the supplied bounds relative to its parent.

#### `view.getBounds()` _Experimental_

Returns the position and size of the view.

#### `view.setBackgroundColor(color)` _Experimental_

Change the background color of the view.

#### `view.getParent()` _Experimental_

Returns `View || null` - The parent view, otherwise returns `null`.

#### `view.getWindow()` _Experimental_

Returns `BaseWindow || null` - The window that the view belongs to, otherwise returns `null`.

#### `view.removeChildView(view)` _Experimental_

* `view` View

#### `view.getChildren()` _Experimental_

Returns `View[]` - an array of all Views that have been attached
with `addChildView`.

### Events

#### Event: 'size-changed' _Experimental_

Emitted when the view's size has been changed.

 
## BaseWindow 

### New instance methods

#### `win.addChildView(view)` _Experimental_

* `view` View

#### `win.removeChildView(view)` _Experimental_

* `view` View

#### `win.getChildren()` _Experimental_

Returns `View[]` - an array of all Views that have been attached
with `addChildView`.


## ScrollView

The `ScrollView` can show an arbitrary content view inside it. It is used to make
any View scrollable. When the content is larger than the `ScrollView`,
scrollbars will be optionally showed. When the content view is smaller
then the `ScrollView`, the content view will be resized to the size of the
`ScrollView`.
It extends `View`.

Process: **Main**

### `new ScrollView()` _Experimental_

Creates the new scroll view.

### Instance Methods

#### `scrollView.setContentView(contents)` _Experimental_

Set the contents. The contents is the view that needs to scroll.

#### `scrollView.getContentView()` _Experimental_

Returns `View` - The contents of the `scrollView`.

#### `scrollView.setContentSize(size)` _Experimental_

Set the size of the contents.

#### `scrollView.getContentSize()` _Experimental_

Returns the `size` of the contents.

#### `scrollView.setHorizontalScrollBarMode(mode)` _Experimental_

* `mode` string - Can be `disabled`, `enabled-but-hidden`, `enabled`. Default is `enabled`.

Controls how the horizontal scroll bar appears and functions.
* `disabled` - The scrollbar is hidden.
* `enabled-but-hidden` - The scrollbar is hidden whether or not the contents are larger than the viewport, but the pane will respond to scroll events. _Linux_  _Windows_
*`enabled` - The scrollbar will be visible if the contents are larger than the viewport.

#### `scrollView.setVerticalScrollBarMode(mode)` _Experimental_

* `mode` string - Can be `disabled`, `enabled-but-hidden`, `enabled`. Default is `enabled`.

Controls how the vertical scroll bar appears and functions.

#### `scrollView.getHorizontalScrollBarMode()` _Experimental_

Returns `string` - horizontal scrollbar mode.

#### `scrollView.getVerticalScrollBarMode()` _Experimental_

Returns `string` - vertical scrollbar mode.

#### `scrollView.setHorizontalScrollElasticity(elasticity)` _Experimental_

* `elasticity` string - Can be `automatic`, `none`, `allowed`. Default is `automatic`.

The scroll view’s horizontal scrolling elasticity mode.
A scroll view can scroll its contents past its bounds to achieve an elastic effect. 
When set to `automatic`, scrolling the horizontal axis beyond its document
bounds only occurs if the document width is greater than the view width,
or the vertical scroller is hidden and the horizontal scroller is visible.
* `automatic` - Automatically determine whether to allow elasticity on this axis.
* `none` - Disallow scrolling beyond document bounds on this axis.
* `allowed` - Allow content to be scrolled past its bounds on this axis in an elastic fashion.

#### `scrollView.setVerticalScrollElasticity(elasticity)` _Experimental_

* `elasticity` string - Can be `automatic`, `none`, `allowed`. Default is `automatic`.

The scroll view’s vertical scrolling elasticity mode.

#### `scrollView.getHorizontalScrollElasticity()` _Experimental_

Returns `string` - The scroll view’s horizontal scrolling elasticity mode.

#### `scrollView.getVerticalScrollElasticity()` _Experimental_

Returns `string` - The scroll view’s vertical scrolling elasticity mode.

#### `view.setScrollPosition(point)` _Experimental_

* `point` - The point in the `contentView` to scroll to.

Scroll to the horizontal (`point.x`) and vertical (`point.y`) position.

#### `view.getScrollPosition()` _Experimental_

Returns `Point` - The horizontal and vertical scroll position.

#### `view.getMaximumScrollPosition()` _Experimental_

Returns `Point` - The maximum horizontal and vertical scroll position.

#### Events

#### Event: 'did-scroll' _Experimental_

Returns:

* `event` Event

Emitted when the content view is being scrolled.

#### Event: 'start-scroll' _Experimental_

Returns:

* `event` Event

Emitted at the beginning of user-initiated scrolling.

#### Event: 'end-scroll' _Experimental_

Returns:

* `event` Event

Emitted at the end of user-initiated scrolling.

## Rollout Plan

- duplicate the BrowserView API (setAutoResize, setBounds etc.) into View API; targeting Electron v21
- add the documentation to [Views API (Part 1)](views-api-1-content-view.md); targeting Electron v21
- adjust BaseWindow API to support the hierarchy of views (WebContentsViews); targeting Electron v21
- add the ScrollView API (as experimental); targeting Electron v22
- optimization the ScrollView with WebContentsViews for performance; targeting Electron v22
