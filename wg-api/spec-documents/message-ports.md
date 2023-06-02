# MessagePorts in Electron

## Problem

It's common for Electron apps to use a hidden renderer for a variety of reasons: to execute untrusted code in a sandboxed background window, to relegate CPU-intensive work to another process, or to isolate crash-prone components. Currently, it's non-trivial to communicate directly from one renderer process to another unrelated process (i.e. one not opened by `window.open`): either one must relay via the main process through `sendToFrame`, or use a 3rd-party native module such as `node-ipc`.

I propose that we reuse and extend the already-existing web-standard [Channel Messaging API][channel-messaging-api] to facilitate communication between renderers, and as a bonus, take the opportunity to add a powerful new IPC primitive to Electron: message channels.

## Background

### The Channel Messaging API

The [Channel Messaging API][channel-messaging-api] is a web standard that builds on `postMessage` by allowing the creation of multiple independent channels across which messages can be sent. On the web, it can be used to communicate with Web Workers, Service Workers, or between windows (or even within the same window, somewhat redundantly).

Here's a short example of usage on the Web:

```javascript=
const {port1, port2} = new MessageChannel();
port1.onmessage = (e) => console.log('port1 got message', e.data);
someOtherWindow.postMessage(
    `here's the other end of the channel`, '*', [port2]);

// In the other window
window.onmessage = (e) => {
  const port2 = e.ports[0]
  port2.postMessage('send a message over the channel')
  // port1.onmessage will be triggered
}
```

Under the hood, this is a light wrapper around Mojo pipes and the same algorithms that `window.postMessage` uses.

### Node.js worker threads

Node.js took inspiration from the Channel Messaging API when they designed the [communication system for worker threads](https://nodejs.org/dist/latest-v12.x/docs/api/worker_threads.html#worker_threads_class_messagechannel).

### Transferables

In the `postMessage` API, one of the options available when sending a message is to pass a list of *transferables* to be passed along with the message. These objects, once transferred through `postMessage`, are no longer accessible to the sender, and ownership is transferred to the receiver. Some examples of transferable objects are `ArrayBuffer`, `ImageBitmap` and `MessagePort`.

References to transferred objects can appear in the message data, and when deserialized, the message on the receiving end will contain references to those transferred objects in the appropriate place.

## Proposal

I propose that we add a new IPC primitive to Electron based on and interoperable with the Channel Messaging API.

### New API surface

#### ipcRenderer

##### `ipcRenderer.postMessage(channel, message[, options])`

* `channel` String
* `message` any
* `options` Object (optional)
  * `transfer` any[] - a list of transferable objects to be sent with the message.

This behaves similarly to `window.postMessage`, but instead of sending a message to another window, it sends the message to the main process.

Also, this behaves similarly to `ipcRenderer.send`, but only takes a single argument after the channel (the message to be sent), and allows for additional options to be specified. In particular, it allows specifying a list of transferable objects to be sent along with the message.

When this message is received in the main process, any `MessagePort` objects transferred will be deserialized as `ipcMain.MessagePort`.

#### Class: WebContents

##### `WebContents.postMessage(channel, message[, options])`

* `channel` String
* `message` any
* `options` Object (optional)
  * `transfer` any[] - a list of transferable objects to be sent with the message.

Similar to `WebContents.send`, but allows transferring transferable objects.

> \[name=Samuel Attard]
> I'm trying to figure out if there's a way for this to be non-breaking integrated into `.send` to avoid the confusion around two different ways to send IPC.  Can't see an easy way out there though.

#### Class: ipcMain.MessageChannel extends EventEmitter

Analogous to Blink's `MessageChannel`, but outside of Blink. Allows creating MessageChannels in the main process.

##### Instance Properties

* `port1` ipcMain.MessagePort
* `port2` ipcMain.MessagePort

#### Class: ipcMain.MessagePort

Analogous to Blink's `MessagePort`, but outside of Blink. If sent to a renderer process, deserializes as a Blink `MessagePort`.

##### Instance Methods

###### `MessagePort.postMessage(message[, transferList])`

See [Web Messaging](https://html.spec.whatwg.org/multipage/web-messaging.html#dom-messageport-postmessage), [Node](https://nodejs.org/dist/latest-v12.x/docs/api/worker_threads.html#worker_threads_port_postmessage_value_transferlist).

###### `MessagePort.start()`

See [Web Messaging](https://html.spec.whatwg.org/multipage/web-messaging.html#dom-messageport-start), [Node](https://nodejs.org/dist/latest-v12.x/docs/api/worker_threads.html#worker_threads_port_start)

###### `MessagePort.close()`

See [Web Messaging](https://html.spec.whatwg.org/multipage/web-messaging.html#dom-messageport-close), [Node](https://nodejs.org/dist/latest-v12.x/docs/api/worker_threads.html#worker_threads_port_close)

##### Instance Events

###### Event: 'message'

Emitted when the port receives a message.

###### Event: 'close'

Emitted when the channel is closed.

::::warning
:warning: This event is not part of the Web Messaging API.
::::

> \[name=Samuel Attard]
> Is there a way to tell if a message port has been closed *after* the fact.  E.g. `port.isClosed` or something?  Otherwise I assume `postMessage` will throw if the port is closed and you try to send a message.

## Example usage of new API

### Direct renderer-to-renderer communication

In the following example, the main process creates a channel, and then sends each end of it to a different renderer. Subsequent communication over that channel is direct between the two renderers, without the involvement of the main process.

*ui_renderer.js*

```javascript
let workerConnection = null
ipcRenderer.on('worker_connection', (e, {port}) => {
  workerConnection = port
  beginWork()
})

function beginWork() {
  workerConnection.postMessage({operation: 'foo', data: [...]})
  workerConnection.onmessage = (message) => {
    // ... do something with the message from the worker renderer ...
  }
}
```

*worker_renderer.js*

```javascript
ipcRenderer.on('register', (e, {port}) => {
  port.onmessage = handleOperation(port)
})

const handleOperation = (port) => async ({operation, data}) => {
  switch (operation) {
    case 'foo': {
      const result = await doFooTo(data)
      port.postMessage({result})
    }
  }
}
```

*main.js*

```javascript
const worker = new BrowserWindow({
  show: false,
  webPreferences: {nodeIntegration: true}
})
const ui = new BrowserWindow({
  webPreferences: {nodeIntegration: true}
})

worker.loadURL(
  'data:text/html,<script src="worker_renderer.js"></script>')
  
ui.loadURL(
  'data:text/html,<script src="ui_renderer.js"></script>')
  
const {port1, port2} = new MessageChannel

worker.webContents.postMessage('register', {port: port1}, [port1])
ui.webContents.postMessage('worker_connection', {port: port2}, [port2])
```

## Discussion

### Underlying implementation

In Blink, `MessagePort` is a fairly thin wrapper around a Mojo pipe. Node's messaging API is only used to communicate within a single process (between threads), so there is no underlying IPC mechanism, just process-local message queues and message serialization.

### Internal IPC

In our current IPC implementation we have a boolean flag for whether an IPC message is 'internal' or not, and we avoid exposing internal IPCs to users. Using the new channel messaging API, it would be possible to create an 'internal' channel over which such messages could be sent—in fact, we could create as many different channels as we liked. In particular, it would be useful to separate each different Electron API into its own channel, which would eliminate the possibility of namespace collision between APIs, and additionally provide a security feature: possession of the channel port implies permission to use the API, and without a port it would be impossible to use that feature.

> \[name=Samuel Attard]
> This design would be that *all* APIs would by definition become async in the renderer if they required IPC to back them as I'm assuming we wouldn't make a `postMessageSync` API.  This means all usages of `sendSync` or `invokeSync` either get stuck on the old API or have to have breaking API changes.  It sounds like a lot of our internal impls wouldn't be able to use this because of this restriction.

### 'close' event

The Channel Messaging API on the Web does not specify a 'close' event (see [whatwg/html#1776](https://github.com/whatwg/html/issues/1766)), whereas the Node.js Worker API does. Knowing when the remote end of a channel has been closed seems like an important feature and it is concerning to me that the Web API doesn't allow for detecting that state.

There have been several discussions (going [as far back as 2013](https://lists.w3.org/Archives/Public/public-whatwg-archive/2013Oct/0003.html#options3)) proposing to add the 'close' event to the Channel Messaging API. If we find that this is a critical feature for use in Electron, we might consider advocating for its inclusion in the standard, as well as patching it in to Chromium.

### Other usages

As written, this API would provide a way to establish direct renderer-to-renderer communication, as well as a new way to divide the namespace of IPC messages, and a way to provide an [object-capability model](https://html.spec.whatwg.org/multipage/web-messaging.html#ports-as-the-basis-of-an-object-capability-model-on-the-web). It would also be possible to bind a MessagePort to a Node worker thread in the main process, allowing direct communication from a renderer to a background thread in the main process.

The addition of the option to specify transferables along with messages sent between processes could in future be extended to allow transferring new kinds of objects. For instance, we could allow transferring file handles, or [Streams](https://streams.spec.whatwg.org/).

[channel-messaging-api]: https://developer.mozilla.org/en-US/docs/Web/API/Channel_Messaging_API
