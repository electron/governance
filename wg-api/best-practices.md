# Public API Best Practices

This is a draft for best practices when designing public APIs.

## Module

### Module Name

If a module exports only one class, the module's name should be the class's name.

For example:

```javascript
const { BrowserWindow } = require('electron')
```

If a module includes methods or more than one class, the module's name should be in `lowerCamelCase`.

For example:

```javascript
const { nativeImage } = require('electron')
nativeImage.createEmpty()
```

## Class

### Creating Instance

There are 2 styles for creating instances of classes:

```javascript
const { BrowserWindow, nativeImage } = require('electron')

// Constructor
new BrowserWindow(options)

// Factory method
nativeImage.createFromPath('/path')
```

#### Constructor

If the class has inheritance relationship with other public classes, constructor should be used.

For example:

```javascript
const { BrowserWindow, TopLevelWindow } = require('electron')
const win = new BrowserWindow(options)
```

This enables users to detect inheritance relationships between classes.

```javascript
if (win instanceof TopLevelWindow) {
  // ...
}
```

#### Factory method

If the class accepts different kinds of parameters with options, we should consider using factory methods.

For example:

```javascript
// Using module methods
const { nativeImage } = require('electron')
nativeImage.createFromNamedImage('NSImageNameListViewTemplate', [-1, 0, 1])

// Using static methods
Buffer.from('7468697320697320612074c3a97374', 'hex')
```

One reason is ambiguities and usability issues, the `Buffer` API is a good example: [Node.js Buffer API Changes][node-buffer-api].

Another reason is, due to lack of function overloading, JavaScript class's constructor can only be implemented with a single C++ function, and it is error-prone to parse different kinds of parameters with C++ manually. While factory methods can be perfectly mapped to C++ functions, making the code much easier to read and maintain.

### Instance Event

If the class generates events, it should inherit from `EventEmitter` and use its interface for emitting events.

### Instance Property

If an API of the class returns _non-assignable_ `Object`, and the returned objects always strictly equal each other, the API should be implemented as property.

For example:

```javascript
const win = new BrowserWindow(options)
win.webContents === win.webContents
win.webContents.session === win.webContents.session
win.webContents.debugger === win.webContents.debugger
```

If an API of the class returns [non-primitives][no-primitive], and the returned values do not always strictly equal each other, it should _not_ be implemented as property.

For example:

```javascript
// Should NOT do these, as they have no effect.
const win = new BrowserWindow(options)
win.bounds.x = 42
win.browserViews.push(new BrowserView())
```

### Instance Method

If an API accepts options, or may accept option in future, it should be implemented as method.

For example:

```javascript
const win = new BrowserWindow(options)
win.setBounds(bounds, animate)
```

### Method vs Property (Option A)

Unless for good reason, APIs that set/get values should use methods instead of properties.

For example:

```javascript
const win = new BrowserWindow(options)
win.setTitle('str')
console.log(win.getTitle())
```

### Method vs Property (Option B)

Unless for good reason, APIs that set/get values should use properties instead of methods.

For example:

```javascript
const win = new BrowserWindow(options)
win.title = 'str'
console.log(win.title)
```

### Method vs Property (Option C)

There is no requirement on whether to use method or property. _(This chapter should be removed)_

## Asynchronous APIs

If an API returns _one_ result asynchronously for each call, it should use `Promise`.

For example:

```javascript
const win = new BrowserWindow(options)
const result = await win.webContents.executeJavaScript('void 0')
```

For subscription-style API that returns results for multiple times, it should still use callbacks.

```javascript
// Should still use callback if results are returned for multiple times.
win.hookWindowMessage('MESSAGE', (args...) => {
  // ...
})
```

[node-buffer-api]: https://medium.com/@jasnell/node-js-buffer-api-changes-3c21f1048f97
[no-primitive]: https://developer.mozilla.org/en-US/docs/Glossary/Primitive
