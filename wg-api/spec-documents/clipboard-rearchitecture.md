# Clipboard Module Rearchitecture

> Shelley Vohr and John Kleinschmidt

## Summary

This RFC outlines a rearchitecturing of the `clipboard` module in Electron to improve alignment with the Clipboard API as specified by the [W3C](https://w3c.github.io/clipboard-apis/#clipboard-interface).

## Platforms

All - macOS, Windows, Linux.

## Impetus

Over the course of the last few months, Chromium has been making significant changes to their Clipboard API, including the ability to handle [Custom Formats](https://bugs.chromium.org/p/chromium/issues/detail?id=106449). Electron has had to break small aspects of its clipboard API to account for this, and it's unclear what other changes we may be forced to adapt to as they continue this work. Beyond this, users have been asking for an improved Clipboard API as well as surfaced a number of bugs with its current implementation - the most detailed of which is [here](https://github.com/electron/electron/issues/23156).

Some other related issues include:

- [#31130](https://github.com/electron/electron/issues/31130)
- [#31115](https://github.com/electron/electron/issues/31115)
- [#30699](https://github.com/electron/electron/issues/30699)
- [#26377](https://github.com/electron/electron/issues/26377)
- [#11838](https://github.com/electron/electron/issues/11838)
- [#9035](https://github.com/electron/electron/issues/9035)
- [#5078](https://github.com/electron/electron/issues/5078)
- [electron/governance#229](https://github.com/electron/governance/pull/229)

Electron provided a `clipboard` API to its users preceding the specification of the [Clipboard API by the W3C](https://w3c.github.io/clipboard-apis/#clipboard-interface). As a result, we locked into an API surface and created an API contract with our users that became progressively harder to alter without breaking said contract while the web drove a more standardized approach. On top of this confusion, the `clipboard` module provided by Electron is a dual-process module, meaning that it exists in parallel to the more robust API provided by Chromium in the renderer process via `navigator.clipboard` global. 

At this point, it becomes clear that it is in users' and maintainers' best interest to reconsider how we approach the `clipboard` module - breaking changes might be difficult in the short term but provide more consistency and functionality as we look to the future of the module.

## API Design

The largest consideration for changes to the `clipboard` module is to what degree we should choose to align with the W3C specification. As we consider this, we should consider what needs or use cases might exist for Electron uses which necessarily wouldn't exist for Chrome users, and how we would plan to account for that in our new design.

### Potential Options

1. Strict alignment with W3C specification - no additional APIs exposed.
2. Alignment with W3C where possible, with some additional APIs exposed to handle desktop use cases which aren’t addressed by the specification.
3. Leave API as-is and continue to adapt it as required by upstream changes by Chromium development.
 
### Preferred Approach/Solution

Alignment with W3C where possible, with some additional APIs exposed to handle desktop use cases which aren’t considered by the specification.

**APIs to Preserve**
* `clipboard.readBookmark()`
  * Not supported through existing Web APIs or in the specification.
* `clipboard.writeBookmark(title, url[, type])`
  * Not supported through existing Web APIs or in the specification.
* `clipboard.readFindText()` _macOS_
  * Not supported through existing Web APIs or in the specification.
* `clipboard.writeFindText(text)`
  * Not supported through existing Web APIs or in the specification.
* `clipboard.clear([type])`
  * Not supported through existing Web APIs or in the specification.
* `clipboard.readText([type])`
  * Already implemented per specification.
* `clipboard.writeText(text[, type])`
  * Already implemented per specification.

**APIs to Remove**
* `clipboard.availableFormats([type])`
  * Superseded by `clipboard.read` [Web API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/read)
* `clipboard.has(format[, type])` 
  * Superseded by `clipboard.read` [Web API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/read)
* `clipboard.readBuffer(format)`
  * Superseded by `clipboard.read`[Web API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/read)
* `clipboard.writeBuffer(format, buffer[, type])`
  * Superseded by `clipboard.write` [Web API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/write)
* `clipboard.readHTML()`
  * Superseded by `clipboard.read` with `text/html` MIME type
* `clipboard.writeHTML(markup[, type])`
  * Superseded by `clipboard.write` with `text/html` MIME type
* `clipboard.readImage([type])`
  * Superseded by `clipboard.read()` with `image/*` (where * is bmp, gif, jpeg, png, svg+xml, etc.)
* `clipboard.writeImage(image[, type])`
  * Superseded by `clipboard.write`  with `image/*` (where * is bmp, gif, jpeg, png, svg+xml, etc.)
* `clipboard.readRTF([type])`
  * Superseded by `clipboard.read` with `application/rtf` MIME type
* `clipboard.writeRTF(text[, type])`
  * Superseded by `clipboard.write` with `application/rtf` MIME type

**APIs to Modify**
* `clipboard.read(format)`
  * Modify to bring into spec compliance with [Web API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/read) `clipboard.read`
  * Ensure that raw formats are preserved
    * Custom MIME types e.g. `electron/filepath`
* `clipboard.write(data[, type])​`
  * Modify to bring into spec compliance with [Web API](https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/read) `clipboard.read`
  * Ensure that raw formats are preserved
    * Custom MIME types e.g. `electron/filepath`
  
**APIs to Add**
* `onclipboardchange` event
  * Outlined in the spec but has yet been implemented by Chromium (see [this crbug](https://bugs.chromium.org/p/chromium/issues/detail?id=933608))
  * We would implement this as such time Chromium does so.

### Usage examples

TODO

## Rollout Plan

TODO
