# Protocol Module Simplification

## Summary

Expose `protocol.registerProtocol` and `protocol.interceptProtocol` to allow
any type of protocol response, simplifying the API surface of the `protocol`
module. Add several classes to replace the overloaded
`ProtocolResponse` object. Deprecate the current
`protocol.{intercept|register}{Buffer|File|Http|Stream|String}Protocol`
methods.

## Platforms

All

## Impetus

The current `protocol` module API is a bit unwieldy with 10 typed
methods. They all use an overloaded [`ProtocolResponse`] object and the
existing implementation silently ignores keys not used by any given method.
From a developer perspective it isn't very friendly or discoverable, and
the heavily overloaded nature of the [`ProtocolResponse`] object makes typing
less useful since it does not associate the possible keys with their response
type.

Changes to the implementation over the past couple years have made it possible
to easily provide an any response type API, and both of the proposed methods
exist in the current implementation as undocumented methods, with a moderately
different API than is being proposed here.

## API Design

The current undocumented implementation takes two arguments to the callback,
the first is the type of response to send, and the second is the value normally
used in the callback of the typed version of the method
(e.g. `string` | `ProtocolResponse`).

While functional, that API still suffers from the overloaded
[`ProtocolResponse`] object, and requires explicitly stating the response type
when it can be inferred from the value provided.

I propose several classes which solve both of those issues. The main class,
`ProtocolResponse`, is loosely modeled after the `fetch` API's `Response` class
and [its constructor][response-constructor]. The use of classes is more
intuitive and allows cleaner extension and reusability in user-land, as well
as more flexibility for future changes to the API.

### No More `callback`

Promises are a more natural way of working with an API like this, and can be
used in a way where the developer doesn't have to care - the handler could be
a `function`, `async function`, or manually return a `Promise` if they want.

The manual `callback` idiom is prone to developer mistakes, such as a code path
which forgets to call it, leaving it dangling. By dropping the `callback` idiom
this can only happen in situations where the developer creates their own
`Promise`, which would likely be a somewhat uncommon occurrence. Typescript
also understands and can enforce that the handler must return one of the typed
values, where as it can not detect and enforce not calling `callback` on some
code path.

This can be accomplished via syntactic sugar entirely in JavaScript land by
wrapping the native functions in `lib\browser\api\protocol.ts`. For example,
wrapping the existing `protocol.interceptStringProtocol` could look like:

```typescript
protocol.interceptStringProtocol = function (proto: string, handler: Function) {
  return protocol._interceptStringProtocol(proto, async (request: any, callback: Function) => {
    try {
      callback(await handler(request));
    } catch {
      callback();
    }
  });
};
```

It could also be done in C++, but there's no current implementation for
accomplishing an API like that in the C++ codebase, so it may be simpler to
implement in JavaScript land.

### New API surface

#### `protocol.registerProtocol(scheme, handler)`

* `scheme` String
* `handler` Function => Promise\<ProtocolResponse>
  * `request` ProtocolRequest

#### `protocol.interceptProtocol(scheme, handler)`

* `scheme` String
* `handler` Function => Promise\<ProtocolResponse>
  * `request` ProtocolRequest

#### Class: ProtocolResponse

##### `new ProtocolResponse([body], [options])`

* `body` (Buffer | Stream | String) (optional)
* `options` Object (optional)
  * `statusCode` Number (optional) - The HTTP response code, default is `200`.
  * `charset` String (optional) - The charset of response body, default is
    `"utf-8"`.
  * `mimeType` String (optional) - The MIME type of response body, default is
    `"text/html"`. Setting `mimeType` would implicitly set the `content-type`
    header in response, but if `content-type` is already set in `headers`, the
    `mimeType` would be ignored.
  * `headers` Record<string, string | string[]> (optional) - An object
    containing the response headers. The keys must be String, and values must
    be either String or Array of String.

This class handles the responses currently handled by the
`protocol.{intercept|register}{String|Buffer|Stream}Protocol` methods.

#### Class: FileProtocolResponse extends ProtocolResponse

##### `new FileProtocolResponse(path[, options])`

* `path` String
* `options` Object (optional)
  * `statusCode` Number (optional) - The HTTP response code, default is `200`.
  * `charset` String (optional) - The charset of response body, default is
    `"utf-8"`.
  * `mimeType` String (optional) - The MIME type of response body, default is
    `"text/html"`. Setting `mimeType` would implicitly set the `content-type`
    header in response, but if `content-type` is already set in `headers`, the
    `mimeType` would be ignored.
  * `headers` Record<string, string | string[]> (optional) - An object
    containing the response headers. The keys must be String, and values must
    be either String or Array of String.
  * `referrer` String (optional) - The `referrer` URL.
  * `method` String (optional) - The HTTP `method`.

This class handles the file response case. Note the last two options not
shared with `ProtocolResponse`.

### Failing Requests

Several possible APIs could be used for failing requests, which is currently
handled by the `error` value in the `ProtocolResponse`:

* Return an integer value, with the same possible values as the current `error`
* An integer value as the value for `body` in the `ProtocolResponse`
  constructor
  * This overloads the constructor arguments making it a less attractive option
* A new class for the purpose such as `FailProtocolResponse`
* Making `ProtocolRequest` a class and providing a `ProtocolRequest.abort()` or
  `ProtocolRequest.fail()` method
  * This is a bit awkward with the async nature - does it require returning
    the result? What if you call it and then also return a `ProtocolResponse`?

My personal preference is for the first option.

### Continuing Intercepted Requests

Several possible APIs could be used for continuing requests, which is not
possible in the current API (with [PR #26065] seeking to implement it). Ideally
there would also be a way to modify the request before continuing it, such as
changing headers, although this functionality is already covered by the
`webRequest` module.

* The [PR #26065] implementation
* Return the `request`
* A new class such as `ContinueInterceptedRequest`
  * This has the benefit of allowing extra hooks like an `abort` method
    which could be used to provide functionality such as enforcing a timeout
  * Would not extend `ProtocolResponse`, so that typing could exclude it as
    a possible return type for `registerProtocol` since it only makes sense
    for `interceptProtocol`.
* Making `ProtocolRequest` a class and providing a `ProtocolRequest.continue()`
  method
  * Suffers from the same awkwardness described in 'Failing Requests'

My personal preference is for the `ContinueInterceptedRequest` class, as it is
the most flexible. The constructor could take options to add headers, set the
`referrer`, etc. It could borrow several pages from the existing
`ClientRequest` class, such as the `abort()`, `getUploadProgress()`, and
`followRedirect()` methods. This would allow intercepting to exert greater
control over the request.

### `protocol.{register|intercept}HttpProtocol` Replacement

This method is used to make a new request and pipe the response back to the
original request. From the implementation class:

```c++
// Different from creating a new loader for the URL directly, protocol handlers
// using this loader can work around CORS restrictions.
```

If the CORS restrictions could be worked around, I think the cleanest solution
would be to replace this with using the existing `ClientRequest` class, and
return the `IncomingResponse`. This would provide greater control and reusing
existing APIs has a nice synergy effect.

```javascript
protocol.registerProtocol('myapp', (request) => {
  const requestToPipe = net.request({
    method: 'GET',
    url: 'https://github.com/'
  });
  return new Promise(resolve => {
    requestToPipe.on('response', resolve);
    requestToPipe.end();
  });
});
```

If the usage of `ClientRequest` is not possible, then a new
`PipedHttpProtocolResponse` class similar to `FileProtocolResponse` could be
provided.

### Naming

As always, naming things is hard. Any of the names in the previous sections
are fluid. If they're considered too verbose, they could be shortened since
they will likely be used with their module prefix anyway, so `ProtocolResponse`
could just be `protocol.Response`.

### Usage examples

```typescript
class JsonProtocolResponse extends ProtocolResponse {
  constructor (body, options) {
    const headers = (options || {}).headers || {};
    headers['Content-Type'] = 'application/json';

    super(JSON.stringify(body), { ...options, headers });
  }
}

protocol.interceptProtocol('https', (request) => {
  const { host, pathname } = url.parse(request.url);
  let response;

  if (host === 'myapp.local') {
    if (pathname.startsWith('/static/')) {
      response = new FileProtocolResponse(path.normalize(`${__dirname}/${pathname}`));
    } else if (pathname === 'about.json') {
      response = new JsonProtocolResponse({ name: 'API example' });
    } else {
      response = new ProtocolResponse('Hello World');
    }
  }

  return response ? response : new ContinueInterceptedRequest();
});
```

### Polyfill

The suggested API changes can be polyfilled with the following code, excluding
continuing intercepted requests and the
`protocol.{register|intercept}HttpProtocol` replacement.

It is only for illustrative purposes or playing around with the proposed API
changes, it is not a suggested implementation - things will be less awkward
to implement in C++.

Uses `protocol.newInterceptProtocol` and `protocol.newRegisterProtocol` as
there are issues overriding the C++ implemented methods.

```typescript
import { Stream } from 'stream';

interface ProtocolResponseOptions {
  statusCode?: string,
  charset?: string,
  mimeType?: string,
  headers?: Record<string, string | string[]>
}

interface FileProtocolResponseOptions extends ProtocolResponseOptions {
  referrer?: string,
  method?: string
}

class ProtocolResponse {
  protocolType: string;
  body?: Buffer | Stream | string;
  options: ProtocolResponseOptions;

  constructor ();
  constructor (body?: Buffer | Stream | string | ProtocolResponseOptions);
  constructor (body?: Buffer | Stream | string, options?: ProtocolResponseOptions) {
    if (Buffer.isBuffer(body)) {
      this.protocolType = 'buffer';
    } else if (body instanceof Stream) {
      this.protocolType = 'stream';
    } else {
      // Type won't actually be used, just a fallback since with the
      // current API *some* type has to be provided, even if unused
      this.protocolType = 'string';

      if (typeof body === 'object') {
        options = body;
        body = undefined;
      }
    }

    this.body = body;
    this.options = options || {};
  }
}

class FileProtocolResponse extends ProtocolResponse {
  path: string;

  constructor (path: string, options?: FileProtocolResponseOptions) {
    super();

    this.protocolType = 'file';
    this.path = path;
    this.options = options || {};
  }
}

protocol.newInterceptProtocol = function (proto: string, handler: (request: any) => Promise<ProtocolResponse|Number>) : boolean {
  return protocol.interceptProtocol(proto, async (request: any, callback: Function) => {
    try {
      const response = await handler(request);

      if (typeof response === 'number') {
        callback('string', { error: response });
      } else if (response instanceof FileProtocolResponse) {
        callback(response.protocolType, { ...response.options, path: response.path });
      } else if (response instanceof ProtocolResponse) {
        callback(response.protocolType, { ...response.options, data: response.body || '' });
      }
    } catch {
      callback();
    }
  });
};

protocol.newRegisterProtocol = function (proto: string, handler: (request: any) => Promise<ProtocolResponse|Number>) : boolean {
  return protocol.registerProtocol(proto, async (request: any, callback: Function) => {
    try {
      const response = await handler(request);

      if (typeof response === 'number') {
        callback('string', { error: response });
      } else if (response instanceof FileProtocolResponse) {
        callback(response.protocolType, { ...response.options, path: response.path });
      } else if (response instanceof ProtocolResponse) {
        callback(response.protocolType, { ...response.options, data: response.body || '' });
      }
    } catch {
      callback();
    }
  });
};

protocol.ProtocolResponse = ProtocolResponse;
protocol.FileProtocolResponse = FileProtocolResponse;
```

## Rollout Plan

This will live in `v12.0.0` and beyond, with the specifically typed methods
being deprecated and removed in a later release.

[response-constructor]:
https://developer.mozilla.org/en-US/docs/Web/API/Response/Response
[PR #26065]: https://github.com/electron/electron/pull/26065
[`ProtocolResponse`]:
https://www.electronjs.org/docs/api/structures/protocol-response
