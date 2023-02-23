---
action:
 - add 'blocked/need-info' label
---

Could you please attach a crash dump to help us get more information? You can collect them by adding the following snippet to your main process code, before app.whenReady:

```
const { app, crashReporter } = require('electron')

console.log(app.getPath('crashDumps'))
crashReporter.start({ submitURL: '', uploadToServer: false })
```
Then reproduce the crash, zip up the crash dumps directory and attach it here. I'm adding the `blocked/need-info` label until we have access to the crash dumps.

Thanks in advance! Your help is appreciated.
