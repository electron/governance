# `clipboard.writeBuffers(buffersObject)`

## Summary

A new `clipboard.writeBuffers(buffersObject)` API method is introduced, tht allows writing multiple low-level `Buffer`-based _native_ formats to the clipboard.

## Platforms
macOS, Windows, Linux

## Impetus

Electron currently provides the `clipboard.write()` API to write multiple high-level _portable_ clipboard formats, but there's currently no similar method to write to multiple low-level _native_ formats: The existing `clipboard.writeBuffer()` API clears the preexisting clipboard contents on each call, due to the behavior of the underlying `ScopedClipboardWriter` Chromium class. Apps that need this functionality currently have to resort to requiring native Node.js modules.

## API Design

The new API is comprised of a single method:

```markdown
### `clipboard.writeBuffers(buffersObject)`

* `buffersObject` Object - An object with `String` keys representing native, platform-dependent clipboard formats and `Buffer` values to be written for each format.
```

## Rollout Plan

This new API would be available at the next major release of Electron. There are no special backporting, backwards compatibility or rollout requirements.
