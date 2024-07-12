# `shell.openItem(item)`

## Summary

`shell.openItem(item)` will be renamed to `shell.openPath(path)` and made asynchronous, returning a Promise. The Promise will contain information reflecting the success of the operation.

## Platforms

**All**

## Impetus

At the moment, the return value of `shell.openItem(item)` arguably does not accurately reflect the success of the underlying operation being performed.

For example, on Linux, `true` can be returned when the file being passed as `item` doesn't exist, since it effectively returns the success of spawning `xdg-open` and not the exit code of `xdg-open` itself.

This new design will resolve ambiguities and allow users to more accurately understand the result of this API call.

## API Design

The new method will adhere to the following semantics:

```markdown
### `shell.openPath(path)`

* `path` String

Returns `Promise<String>` - Resolve with an object containing the following:

* `errorMessage` String - The error message corresponding to the failure if a failure occurred, otherwise "".

Open the given file in the desktop's default manner.
```

An alternative considered was having this new method take an optional callback instead of returning a Promise.

## Rollout Plan

This will live in Electron `v9.0.0` and beyond.
