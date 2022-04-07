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

![](https://user-images.githubusercontent.com/2891206/150981006-84fe796e-60bd-43c0-952d-831d1bfd9998.gif)

## Usage Example

```js
const { BrowserView, BrowserWindow, ContainerView, ScrollView, WrapperBrowserView } = require("electron");

const window = new BrowserWindow({ width: 1000, height: 500 })

const scroll = new ScrollView()
scroll.setBounds({ width: 1000, height: 500 })

const scrollContent = new ContainerView()
scrollContent.setBounds({ width: 2000, height: 500 })

const browserView1 = new BrowserView()
const wrapperBrowserView1 = new WrapperBrowserView({ 'browserView': browserView1 });
wrapperBrowserView1.setBounds({ width: 1000, height: 500 })
scrollContent.addChild(wrapperBrowserView1)

const browserView2 = new BrowserView()
const wrapperBrowserView2 = new WrapperBrowserView({ 'browserView': browserView2 });
wrapperBrowserView2.setBounds({ width: 1000, height: 500, x: 1000 })
scrollContent.addChild(wrapperBrowserView2)

scroll.setContentView(scrollContent);
win.addChild(scroll);
```


## API Design

In order to achieve the example above, we've made following changes to the API

## BaseView

A `BaseView` is a rectangle within the views View hierarchy. It is the base
class for all all different views. 

Process: **Main**

`BaseView` is an EventEmitter

### `new BaseView()`

Creates the new base view.

### Instance Methods

#### `view.setBounds(bounds)`

Resizes and moves the view to the supplied bounds relative to its parent.

#### `view.getBounds()`

Returns the position and size of the view.

#### `view.setBackgroundColor(color)`

Change the background color of the view.

#### `view.getParentView()`

Returns `BaseView || null` - The parent view, otherwise returns `null`.

#### `view.getParentWindow()`

Returns `BrowserWindow || null` - The window that the view belongs to, otherwise returns `null`.

### Events

#### Event: 'size-changed'

Emitted when the view's size has been changed.

 
## BrowserWindow 

### New instance methods

#### `win.addChild(view)`

#### `win.removeChild(view)`

#### `win.getChildren()`

Returns `BaseView[]` - an array of all BaseViews that have been attached
with `addChild`.


## ContainerView

A `ContainerView` can be used to embed additional views hierarchy into a `BrowserWindow`. It extends `BaseView`.

Process: **Main**

### `new ContainerView()`

Creates the new container view.

### Instance Methods

#### `containerView.addChild(view)`

#### `containerView.removeChild(view)`

#### `containerView.getChildren()`

Returns `BaseView[]` - an array of all BaseViews that have been attached
with `addChild`.


## ScrollView

The `ScrollView` can show an arbitrary content view inside it. It is used to make
any View scrollable. When the content is larger than the `ScrollView`,
scrollbars will be optionally showed. When the content view is smaller
then the `ScrollView`, the content view will be resized to the size of the
`ScrollView`.
It extends `BaseView`.

Process: **Main**

### `new ScrollView()`

Creates the new scroll view.

### Instance Methods

#### `scrollView.setContentView(contents)`

Set the contents. The contents is the view that needs to scroll.

#### `scrollView.getContentView()`

Returns `BaseView` - The contents of the `scrollView`.

#### `scrollView.setContentSize(size)`

Set the size of the contents.

#### `scrollView.getContentSize()`

Returns the `size` of the contents.

#### `scrollView.setHorizontalScrollBarMode(mode)`

* `mode` string - Can be one of the following values: `disabled`, `hidden-but-enabled`, `enabled`. Default is `enabled`.

Controls how the horizontal scroll bar appears and functions.
* `disable` - The scrollbar is hidden, and the pane will not respond to e.g. mousewheel events even if the contents are larger than the viewport.
* `hidden-but-enabled` - The scrollbar is hidden whether or not the contents are larger than the viewport, but the pane will respond to scroll events.
*`enabled` - The scrollbar will be visible if the contents are larger than the viewport and the pane will respond to scroll events.

#### `scrollView.setVerticalScrollBarMode(mode)`

Controls how the vertical scroll bar appears and functions.

#### `getHorizontalScrollBarMode()`

Returns `string` - horizontal scrollbar mode.

#### `scrollView.getVerticalScrollBarMode()`

Returns `string` - vertical scrollbar mode.

#### `scrollView.setHorizontalScrollElasticity(elasticity)` _macOS_

* `elasticity` string - Can be one of the following values: `automatic`, `none`, `allowed`. Default is `automatic`.

The scroll view’s horizontal scrolling elasticity mode.
A scroll view can scroll its contents past its bounds to achieve an elastic effect. 
When set to `automatic`, scrolling the horizontal axis beyond its document
bounds only occurs if the document width is greater than the view width,
or the vertical scroller is hidden and the horizontal scroller is visible.
* `automatic` - Automatically determine whether to allow elasticity on this axis.
* `none` - Disallow scrolling beyond document bounds on this axis.
*`allowed` - Allow content to be scrolled past its bounds on this axis in an elastic fashion.

#### `scrollView.setVerticalScrollElasticity(elasticity)` _macOS_

The scroll view’s vertical scrolling elasticity mode.

#### `scrollView.getHorizontalScrollElasticity()` _macOS_

Returns `string` - The scroll view’s horizontal scrolling elasticity mode.

#### `view.getVerticalScrollElasticity()` _macOS_

Returns `string` - The scroll view’s vertical scrolling elasticity mode.

#### `view.setScrollPosition(point)` _macOS_

* `point` - The point in the `contentView` to scroll to.

Scrolls the view’s closest ancestor `clipView` object so a point in the
view lies at the origin of the clip view's bounds rectangle.

#### `view.getScrollPosition()` _macOS_

Returns `Point`

#### `view.getMaximumScrollPosition()` _macOS_

Returns `Point`

#### Events

#### `scroll-started`
#### `scroll-ended`
#### `bounds-did-change`


## WrapperBrowserView

A `WrapperBrowserView` is the wrapper for `BrowserView`. It extends `BaseView`.

Process: **Main**

### `new WrapperBrowserView([options])`

* `options` Object (optional)
  * `browserView` (optional)

If `browserView` is not set then new `BrowserView` is created.

### Instance Properties

#### `view.browserView`

A `BrowserView` object owned by this view.

  
## Rollout Plan

TBD