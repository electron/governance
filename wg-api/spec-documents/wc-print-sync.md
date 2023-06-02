# Print Options Consistency

## Summary

`webContents.print()` and `webContents.printToPDF()` should pass identical parameter types in the same shape. Parameters which differ between the two will be changed to remove differences and prevent unwanted bugs. `webContents.print()` will be Promisified.

## Platforms

All.

## Impetus

`webContents.print()` and `webContents.printToPDF()` pass nearly identical sets of parameters, but given that they were implemented at different times, there is a small delta in the shape in which those parameters are passed in. Our argument sanitization for `webContents.print()` lived natively, and for `webContents.printToPDF()` lives in JavaScript. I plan to refactor these two functions to move all sanitization into JavaScript for the following primary reasons:

* Robust tests cannot as easily be written for malformed parameters given the current state of the two methods
* There is an increasing amount of code duplication to accomplish the same sanitization and setting organization.

## API Design

The following parameter changes will be made:

```markdown
* `marginsType` Integer (optional) - Specifies the type of margins to use. Uses 0 for	default margin, 1 for no margin, and 2 for minimum margin.
```

will become

```markdown
* `margins` Object (optional)
    * `marginType` String (optional) - Can be `default`, `none`, `printableArea`, or `custom`. If `custom` is chosen, you will also need to specify `top`, `bottom`, `left`, and `right`.
    * `top` Number (optional) - The top margin of the printed web page, in pixels.
    * `bottom` Number (optional) - The bottom margin of the printed web page, in pixels.
    * `left` Number (optional) - The left margin of the printed web page, in pixels.
    * `right` Number (optional) - The right margin of the printed web page, in pixels.
```

`printBackground` => `shouldPrintBackgrounds`
`pageRanges` => `pageRange`
`printSelectionOnly` => `shouldPrintSelectionOnly`

`webContents.print()` will no longer take a callback, and instead return a `Promise<void | string>`, where the Promise resolves if printing successfully occurred, and rejects with the failure cause if it did not occur.

## Rollout Plan

I would like for this change to be rolled out with Electron v10 initially. Backwards compatibility will be ensured for two major versions, so the breaking changes associated with this change will affect consumers beginning with Electron v12.
