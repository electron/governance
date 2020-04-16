# Views API (Part 2): Child Views and Layout Engine

## Summary

This spec defines APIs for supporting child views, and proposes to use
[`YogaLayout`](https://yogalayout.com) as layout engine.

(`YogaLayout`) is the layout engine used by React Native.

## Platforms

All.

## Impetus

Since now Electron supports changing window's content view to arbitrary `View`,
it becomes straightforward to support child views since we only need to do a
simple translation of `views` APIs to JavaScript.

The only thing undetermined, is how to control the layout of child views.

The default solution in `views` library, is to define a `LayoutManager` class
for each view, and manually control the bounds of child views. Chromium provides
a few stock `LayoutManager` implementations, all of them have weird interfaces
and are hard to use.

Here I propose taking the solution used by React Native, that uses
[`YogaLayout`](https://yogalayout.com) to control child views' layout.

The `YogaLayout` works like CSS with only flexbox layout: each view defines its
styles and it will be positioned and resized automatically. For people
unfamiliar with React Native, there is a quick guide on how layout works there:
[Layout with Flexbox](https://reactnative.dev/docs/flexbox).

The benefits about `YogaLayout` are:

* We only need one `View.setStyle` API to have full layout support, we can
  easily deprecate it if we want to implement layout in other ways in future.
  Any other way to do layout would require adding significant more APIs and
  classes.
* It is powerful enough for very complex apps, and efficient when resizing. It
  is a widely-used and proven solution.
* It supports absolute position, so users can still manually position and resize
  the views.
* It works with HiDPI perfectly.
* It is very easy to integrate, I have done it before so I'm confident on this.

### Example with `YogaLayout`

This is an example that implements a text editor with sidebar:

<img src="https://cdn.rawgit.com/yue/yue-app-samples/10cc39d9/editor/screenshots/mac_editor.png" width="400" height="422">

(The `Button` and `TextEdit` classes are not yet defined and only demonstration
purpose.)

```js
const win = new TopLevelWindow({})

// The content view has its children arranged horizontally.
const content = new View()
content.setStyle({flexDirection: 'row'})
win.setContentView(content)

// The sidebar is a child of content view and has 5px paddings.
const sidebar = new View()
sidebar.setStyle({padding: 5})
contentView.addChildView(sidebar)

// The buttons in the sidebar, they shows images instead of text.
const open = new Button('')
open.setImage('open@2x.png')
open.setStyle({marginBottom: 5})
sidebar.addChildView(open)
const save = new Button('')
save.setImage('open@2x.png')
sidebar.addChildView(save)

// Make the sidebar have a fixed width which is enough to show all the buttons.
sidebar.setStyle({width: sidebar.getPreferredSize().width})

// The text edit view would take all remaining spaces.
const edit = new TextEdit()
edit.setStyle({flex: 1})
contentView.addChildView(edit)
```

## API Design

There are 2 parts of APIs, one is the child view related APIs that exposed from
`views` library directly, the other is `View.setStyle` and a few layout related
APIs.

### `new View()`

Creates an empty `View` class, it takes almost no resource and usually used as
containers of child views. It is similar to the `div` tag in HTML.

### `view.addChildView(view)`
### `view.addChildViewAt(view, index)`
### `view.removeChildView(view)`
### `view.getChildViewAt(index)`
### `view.getChildren()`

APIs for adding/removing child views.

### `view.setVisible(visible)`
### `view.isVisible()`

Set whether the view is visible.

Note that the layout engine is not responsible for controlling the visibility of
views.

### `view.setBounds(bounds)`

Set bounds of view manually.

This is needed for testing YogaLayout. If we decided to not use YogaLayout, this
would be required for doing layout.

### `view.getBounds()`

Return the bounds of the view.

### `view.getPreferredSize()`
### `view.getMinimumSize()`
### `view.getHeightForWidth(width)`

Utility functions for computing layout.

For people unfamiliar with layout engines, this is why these functions are
needed:

Suppose you are implementing a fixed sidebar with buttons, and you have to give
it a fixed width. You can just hardcode the width if you know exactly what the
text are in the buttons, but for programs that support internationalization, the
text of buttons change under different environments and so it is required to
compute the width required to show all the text in runtime, and this is when
these functions are needed to compute the best size to display a view.

### `view.setStyle({key: value, ....})`

Set the styles defined by `YogaLayout`.

Supported styles in React Native:
[Layout Props](https://reactnative.dev/docs/layout-props).

## Rollout Plan

This will live in Electron `v10.0.0` and beyond.
