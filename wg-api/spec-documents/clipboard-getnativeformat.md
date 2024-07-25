# `clipboard.getNativeFormat(portableFormat)`

## Summary
A new `clipboard.getNativeFormat(portableFormat)` API method is introduced. It returns a `String` representing the underlying _native_ clipboard type for the supplied _portable_ format.

## Platforms
macOS, Windows, Linux

## Impetus

Each operating system supported by Electron utilizes a different convention to identify the data format of the clipboard contents: macOS uses [UTIs](https://en.wikipedia.org/wiki/Uniform_Type_Identifier), Linux uses [MIME types](https://en.wikipedia.org/wiki/MIME) and Windows uses [numeric values](https://docs.microsoft.com/en-us/windows/win32/dataxchg/standard-clipboard-formats).

To increase portability, Electron's `clipboard` API exposes read/write access to several high-level _portable_ clipboard formats (via `write()`, `writeText()`, `readImage()` etc). Lower-level access to the _native_ formats is also provided via `Buffer`-based read/write APIs (via `readBuffer()`, `writeBuffer()`)

There's however, no currently available mechanism to query the underlying low-level _native_ format for a given high-level _portable_ format. Applications that want to have `Buffer` access to these formats are therefore required to make use of hardcoded, platform-specific string contants.

The introduction of the [proposed](clipboard-writebuffers.md) `writeBuffers()` API (that allows simultaneous writes to multiple low-level clipboard formats) makes this issue more prominent, since  Chromium's underlying `ScopedClipboardWriter` implementation currently disallows simultaneously writing `portable` and `native` formats on the same call.

## API Design

The new API is comprised of a single method:

```markdown
### `clipboard.getNativeFormat(portableFormat)`

* `portableFormat` String - One of the supported native formats: `text`, `bookmark`, `html`, `rtf`, `image`

Returns `String` - An opaque, platform-dependent value representing a clipboard format (e.g. `text/plain`, `public.text` or `13`)

If an unsupported portable format is provided, this function will throw an error.
```

## Rollout Plan

This new API would be available at the next major release of Electron. There are no special backporting, backwards compatibility or rollout requirements.
