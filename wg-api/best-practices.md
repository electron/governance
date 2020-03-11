# Public API Best Practices

This is a draft for best practices when designing public APIs.

## Modules

### Module Names

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

## Classes

### Creating Instances

There are 2 styles for creating instances of classes:

```javascript
const { BrowserWindow, nativeImage } = require('electron')

// Constructor
new BrowserWindow(options)

// Factory method
nativeImage.createFromPath('/path')
```

#### Constructors

If the class has an inheritance relationship with other public classes, a constructor should be used for that class.

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

#### Factory methods

If the class accepts different kinds of parameters with options, consider using factory methods.

For example:

```javascript
// Using module methods
const { nativeImage } = require('electron')
nativeImage.createFromNamedImage('NSImageNameListViewTemplate', [-1, 0, 1])

// Using static methods
Buffer.from('7468697320697320612074c3a97374', 'hex')
```

Factory methods help reduce ambiguity and usability issues. The `Buffer` API provides a good example of this: [Node.js Buffer API Changes][node-buffer-api].

Additionally, due to lack of function overloading, JavaScript class constructors can only be implemented with a single C++ function and are error-prone when parsing different kinds of parameters with C++. Conversely, factory methods can be perfectly mapped to C++ functions, thereby making code much easier to read and maintain.

### Instance Events

If the class generates events, it should inherit from `EventEmitter` and use its interface for emitting events.

### Instance Properties

If an API of the class returns a _non-assignable_ `Object`, and the returned objects always strictly equal each other, the API should be implemented as property.

For example:

```javascript
const win = new BrowserWindow(options)
win.webContents === win.webContents
win.webContents.session === win.webContents.session
win.webContents.debugger === win.webContents.debugger
```

If an API of the class returns [non-primitives][primitive], and the returned values do not always strictly equal each other, it should _not_ be implemented as property.

For example:

```javascript
// Should NOT do these, as they have no effect.
const win = new BrowserWindow(options)
win.bounds.x = 42
win.browserViews.push(new BrowserView())
```

### Instance Methods

If an API of the class accepts options, or may accept option in future, it should be implemented as method.

For example:

```javascript
const win = new BrowserWindow(options)
win.setBounds(bounds, animate)
```

### Getters and Setters

If the APIs of the class are used to set/get values, they should be implemented as methods.

If the type of the value being set/get is [primitive][primitive], it should be also added as a property interface for the value.

For example:

```javascript
const win = new BrowserWindow(options)
win.setTitle('str')
console.log(win.getTitle())
// Property also works.
win.title = 'str'
console.log(win.title)
```

## Asynchronous APIs

If an API returns _one_ result asynchronously for each call, it should be implemented with `Promise`.

For example:

```javascript
const win = new BrowserWindow(options)
const result = await win.webContents.executeJavaScript('void 0')
```

Subscription-style APIs that returns results multiple times should still be implemented with callbacks.

```javascript
// Should still use callback if results are returned for multiple times.
win.hookWindowMessage('MESSAGE', (args...) => {
  // ...
})
```

[node-buffer-api]: https://medium.com/@jasnell/node-js-buffer-api-changes-3c21f1048f97
[primitive]: https://developer.mozilla.org/en-US/docs/Glossary/Primitive
