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

### `new BaseView()` _Experimental_

Creates the new base view.

### Instance Methods

#### `view.setBounds(bounds)` _Experimental_

Resizes and moves the view to the supplied bounds relative to its parent.

#### `view.getBounds()` _Experimental_

Returns the position and size of the view.

#### `view.setBackgroundColor(color)` _Experimental_

Change the background color of the view.

#### `view.getParent()` _Experimental_

Returns `BaseView || null` - The parent view, otherwise returns `null`.

#### `view.getWindow()` _Experimental_

Returns `BrowserWindow || null` - The window that the view belongs to, otherwise returns `null`.

### Events

#### Event: 'size-changed' _Experimental_

Emitted when the view's size has been changed.

 
## BrowserWindow 

### New instance methods

#### `win.addChild(view)` _Experimental_

* `view` BaseView

#### `win.removeChild(view)` _Experimental_

* `view` BaseView

#### `win.getChildren()` _Experimental_

Returns `BaseView[]` - an array of all BaseViews that have been attached
with `addChild`.


## ContainerView

A `ContainerView` can be used to embed additional views hierarchy into a `BrowserWindow`. It extends `BaseView`.

Process: **Main**

### `new ContainerView()` _Experimental_

Creates the new container view.

### Instance Methods

#### `containerView.addChild(view)` _Experimental_

* `view` BaseView

#### `containerView.removeChild(view)` _Experimental_

* `view` BaseView

#### `containerView.getChildren()` _Experimental_

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

### `new ScrollView()` _Experimental_

Creates the new scroll view.

### Instance Methods

#### `scrollView.setContentView(contents)` _Experimental_

Set the contents. The contents is the view that needs to scroll.

#### `scrollView.getContentView()` _Experimental_

Returns `BaseView` - The contents of the `scrollView`.

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

#### `scrollView.setHorizontalScrollElasticity(elasticity)` _macOS_ _Experimental_

* `elasticity` string - Can be `automatic`, `none`, `allowed`. Default is `automatic`.

The scroll view’s horizontal scrolling elasticity mode.
A scroll view can scroll its contents past its bounds to achieve an elastic effect. 
When set to `automatic`, scrolling the horizontal axis beyond its document
bounds only occurs if the document width is greater than the view width,
or the vertical scroller is hidden and the horizontal scroller is visible.
* `automatic` - Automatically determine whether to allow elasticity on this axis.
* `none` - Disallow scrolling beyond document bounds on this axis.
* `allowed` - Allow content to be scrolled past its bounds on this axis in an elastic fashion.

#### `scrollView.setVerticalScrollElasticity(elasticity)` _macOS_ _Experimental_

* `elasticity` string - Can be `automatic`, `none`, `allowed`. Default is `automatic`.

The scroll view’s vertical scrolling elasticity mode.

#### `scrollView.getHorizontalScrollElasticity()` _macOS_ _Experimental_

Returns `string` - The scroll view’s horizontal scrolling elasticity mode.

#### `scrollView.getVerticalScrollElasticity()` _macOS_ _Experimental_

Returns `string` - The scroll view’s vertical scrolling elasticity mode.

#### `view.setScrollPosition(point)` _Experimental_

* `point` - The point in the `contentView` to scroll to.

Scrolls the view’s closest ancestor `clipView` object so a point in the
view lies at the origin of the clip view's bounds rectangle.

#### `view.getScrollPosition()` _Experimental_

Returns `Point`

#### `view.getMaximumScrollPosition()` _Experimental_

Returns `Point`

#### Events

#### Event: 'did-scroll' _Experimental_

Returns:

* `event` Event

Emitted when the content view is being scrolled.

#### Event: 'start-scroll' _Experimental_

Returns:

* `event` Event

Emitted at the beginning of user-initiated scroll tracking.

#### Event: 'end-scroll' _Experimental_

Returns:

* `event` Event

Emitted at the end of scroll tracking.

## WrapperBrowserView

A `WrapperBrowserView` is the wrapper for `BrowserView`. It extends `BaseView`.

Process: **Main**

### `new WrapperBrowserView([options])` _Experimental_

* `options` Object (optional)
  * `browserView` (optional)

If `browserView` is not set then a new `BrowserView` is created.

### Instance Properties

#### `view.browserView` _Experimental_

A `BrowserView` object owned by this view.

  
## Rollout Plan

TBD