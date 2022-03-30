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
scrollContent.addBrowserView(wrapperBrowserView1)

const browserView2 = new BrowserView()
const wrapperBrowserView2 = new WrapperBrowserView({ 'browserView': browserView2 });
wrapperBrowserView2.setBounds({ width: 1000, height: 500, x: 1000 })
scrollContent.addBrowserView(wrapperBrowserView2)

scroll.setContentView(scrollContent);
win.addChildView(scroll);
```


## API Design

In order to achieve the example above, we've made following changes to the API

### BaseView

A `BaseView` is a rectangle within the views View hierarchy. It is the base
class for all all different views. 

Process: **Main**

`BaseView` is an EventEmitter


#### Static Methods

* `BaseView.getAllViews()`
* `BaseView.fromId(id)`

#### Instance Properties

* `id` - A `Integer` property representing the unique ID of the view. Each ID is unique among all `BaseView` instances of the entire Electron application.
* `isContainer` (*Readonly, Experimental*) A `boolean` property that determines whether this view is (or inherits from) ContainerView.

#### Instance Methods

* `setBounds(bounds)`
* `getBounds()`
* `setBackgroundColor(color)`
* `getParentView()` - Returns `BaseView || null` - The parent view, otherwise returns `null`.
* `getParentWindow()` - Returns `BrowserWindow || null` - The window that the view belongs to, otherwise returns 	`null`

	*Note: The view can belong to either a view or a window.* 

#### Events

* `size-changed`
  
- - - 

### BrowserWindow 

#### New instance methods

* `addChildView(view)` 
* `removeChildView(view)`
* `getViews()`

- - -

### ContainerView

A `ContainerView` can be used to embed additional views hierarchy into a `BrowserWindow`. It extends `BaseView`

Process: **Main**

#### Static Methods

* `ContainerView.fromId(id)` 

#### Instance Methods

* `addChildView(view)`
* `removeChildView(view)`
* `getViews()` - Returns an array of all BaseViews that have been attached


### ScrollView

Show a part of view with scrollbar.  The `ScrollView` can show an arbitrary content view inside it. It is used to make any View scrollable. When the content is larger than the `ScrollView`, scrollbars will be optionally showed. When the content view is smaller then the `ScrollView`, the content view will be resized to the size of the `ScrollView`. The scrollview supports keyboard UI and mousewheel. It extends `BaseView`.

Process: **Main**


#### Static Methods


* `ScrollView.fromId(id)`

#### Instance Methods

* `setContentView(contents)` Set the contents. The contents is the view that needs to scroll.
* `getContentView()`  * Returns The contents of the `view`.
* `setHorizontalScrollBarMode(mode)` - possible values: `disabled`,  `hidden-but-enabled`, `enabled`. Default is `enabled` 
  * `disable` - The scrollbar is hidden, and the pane will not respond to e.g. mousewheel events even if the contents are larger than the viewport.
  * `hidden-but-enabled` - The scrollbar is hidden whether or not the contents are larger than the viewport, but the pane will respond to scroll events.
  * `enabled` - The scrollbar will be visible if the contents are larger than the viewport and the pane will respond to scroll events.
* `setVerticalScrollBarMode(mode)` - similar as `setHorizontalScrollBarMode`
* `getHorizontalScrollBarMode()`
* `getVerticalScrollBarMode()`
* `setHorizontalScrollElasticity(elasticity)` (*macOS*) - possible values: `automatic`, `none`, `allowed`. Default is `automatic`.
  
  The scroll view’s horizontal scrolling elasticity mode.
  A scroll view can scroll its contents past its bounds to achieve an elastic effect. 
  When set to `automatic`, scrolling the horizontal axis beyond its document bounds only occurs if the document width is greater than the view width, or the vertical scroller is hidden and the horizontal scroller is visible.
  * `automatic` - Automatically determine whether to allow elasticity on this axis.
  * `none` - Disallow scrolling beyond document bounds on this axis.
  * `allowed` - Allow content to be scrolled past its bounds on this axis in an elastic fashion.

* `setVerticalScrollElasticity(elasticity)` (_macOS_) - similar to `setHorizontalScrollElasticity`
* `getHorizontalScrollElasticity()` (_macOS_)
* `getVerticalScrollElasticity()` (_macOS_)
* `scrollTo({ x, y })`


#### Events

* `scroll-started`
* `scroll-ended`


### WrapperBrowserView

A `WrapperBrowserView` is the wrapper for `BrowserView`. It extends [`BaseView`](base-view.md).

Process: **Main**

* `new WrapperBrowserView([options])` - 
  * `options.browserView` (*optional*) - If `browserView` is not set then new `BrowserView` is created.


#### Instance Properties

* `view.browserView` - a `BrowserView` object owned by this view.
  
## Rollout Plan

TBD