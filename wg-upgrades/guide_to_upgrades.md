# Upgrading Chromium in Electron

As a member of the Upgrades Working Group, you'll likely be part of the upgrades rotation, where 1-2 people
on duty work to upgrade Chromium and Node.js in Electron based on the release schedules of the upstream projects.

This guide lays out basic approaches to upgrading Chromium via the automated process determined in [roller](https://github.com/electron/roller).

## The Patch Stage

1. Ensure you've fetched the latest information from upstream Electron.

```console
$ git fetch origin
```

2. Check out a local version of the Chromium upgrade branch.

```console
$ git checkout roller/chromium/main
```

3. Begin applying Electron's patches to the new version of Chromium.

```console
# The -3 argument runs patch application with three-way merge
$ e sync -3
```

It's likely that this initial step will fail - this is because Chromium has changed the code upstream that a given patch is altering and so git no longer understands where it should change the existing code.

4. Complete `e sync -3` by fix patch failures.

To move past Step 4, you'll need to fix each successive patch until `e sync` completes successfully.

### Fixing Patches - The Happy Path

As our scripts apply Electron's patches to its various dependency directories, you'll likely run into (multiple) a sync failure which looks like this:

```console
Applying: pepper plugin support
Using index info to reconstruct a base tree...
M	chrome/renderer/pepper/pepper_helper.h
Falling back to patching base and 3-way merge...
Auto-merging chrome/renderer/pepper/pepper_helper.h
CONFLICT (content): Merge conflict in chrome/renderer/pepper/pepper_helper.h
error: Failed to merge in the changes.
Patch failed at 0017 pepper plugin support
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort
```

When `e sync -3` stops on failure, you should be able to find in console the patch that caused the failure. Then, you should `cd` into the `src` directory (or whichever directory the patch failed to apply in - all possible directories can be seen in [the patch config](https://github.com/electron/electron/blob/main/patches/config.json)),and run `git status` to see what the patch conflicts are. If you're using a code editor like VSCode, you'll likely see an interactive diff like this:

<img width="850" alt="Screen Shot 2021-11-24 at 2 47 38 PM" src="https://user-images.githubusercontent.com/2036040/143304349-76aa846a-1f34-4d3b-a38c-de511e0d7f25.png">

Then, look at the blame and history to determine what change would have caused the patch application to fail. If you're lucky, Chromium will just have moved around a few lines of code or changed something that won't actually affect the change we're intending to make to it with our patch.

In this example, the patch failed on `pepper_helper.h` - the diff indicates that Chromium removed `#include "base/compiler_specific.h"`. The patch just wants to add `#include "base/component_export.h"`, so the conflict can be resolved by removing the compiler include and adding the component export include.

Now, you can add the file (`git add chrome/renderer/pepper/pepper_helper.h`) and then continue with `git am --continue` until all conflicts are resolved for each patch that Electron applies via [the patches directory](https://github.com/electron/electron/blob/main/patches).

**Note:** If the diff is clear enough that you can see what Chromium changed and feel confident in knowing what to do, you don't necessarily need to dig through the Chromium source blame, but it's helpful in allowing you to feel more confident in your changes.

To do this for the above example, you would want to open `pepper_plugin_support.patch` in a code editor and then open the corresponding upstream file in [Chromium's Code Search](`https://source.chromium.org/chromium`). From there, you can look at the file blame, as well as file history:

<img width="1414" alt="Screen Shot 2021-11-25 at 3 17 05 PM" src="https://user-images.githubusercontent.com/2036040/143457403-a8aab42a-02bd-4d9e-adc6-65a35b7a9fb1.png">

To determine or verify what you believe to have changed upstream.

### Fixing Patches: The Advanced Path

For most patches, as noted above, Chromium will just have moved around a few lines of code or changed something that won't actually affect the change we're intending to make to it with our patch.

Sometimes, however, Chromium will make changes that require

## The Build Stage

Once all patches are fixed and `e sync -3` has run, it's time to build Electron.

```
$ e build
```

Electron will at this point start to build as with any changes to source code, with potential failures resultant of changes that Chromium has made upstream. You'll need to diagnose these failures and determine what changes to make in Electron's own source code to address those changes.

For example, if you were to encounter the following build failure:

```console
../../electron/shell/browser/api/electron_api_service_worker_context.cc:42:53: error: no member named 'kAppCache' in 'blink::mojom::ConsoleMessageSource'
  if (source == blink::mojom::ConsoleMessageSource::kAppCache)
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
1 error generated.
[42/164] CXX obj/electron/electron_lib/electron_api_web_frame.o
FAILED: obj/electron/electron_lib/electron_api_web_frame.o
```

the error seems to be saying that an enum class member, `blink::mojom::ConsoleMessageSource::kAppCache`, no longer exists in the enum class `blink::mojom::ConsoleMessageSource`. It's likely, then, that Chromium either removed or renamed it.

To triage further, you would search for this enum class in [Chromium Code Search](`https://source.chromium.org/chromium`), and then look at recent history for the file [found here](https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/public/mojom/devtools/console_message.mojom;drc=de68be3f18ba99cc01d75903e167ca09bade253c;l=14).

By clicking into the history tab, we see the following CL: <img width="1387" alt="Screen Shot 2021-11-24 at 9 45 32 PM" src="https://user-images.githubusercontent.com/2036040/143310655-acb48521-5110-4cdd-83a1-488931104f46.png">

which looks to be referencing the same member the error was about! Next, you would want to click into the [CL review](https://chromium-review.googlesource.com/c/chromium/src/+/3279346) to see what motivated this change and what that might mean needs to be changed in Electron.

The CL simply removes the member with no replacement - the only instance of Electron referencing that member is to convert it to a string, so it can be removed. You would then delete the relevant if statement:

```diff
diff --git a/shell/browser/api/electron_api_service_worker_context.cc b/shell/browser/api/electron_api_service_worker_context.cc
index b9dbbd8723..f148dc7a59 100644
--- a/shell/browser/api/electron_api_service_worker_context.cc
+++ b/shell/browser/api/electron_api_service_worker_context.cc
@@ -39,8 +39,6 @@ std::string MessageSourceToString(
     return "console-api";
   if (source == blink::mojom::ConsoleMessageSource::kStorage)
     return "storage";
-  if (source == blink::mojom::ConsoleMessageSource::kAppCache)
-    return "app-cache";
   if (source == blink::mojom::ConsoleMessageSource::kRendering)
     return "rendering";
   if (source == blink::mojom::ConsoleMessageSource::kSecurity)
```

and then stage and commit this file. It's important to let reviewers and other working group members know why you made this change, so you should reference the CL in this commit to Electron. Each CL has a copy/pasteable string available, which can be found here:

<img width="1553" alt="Screen Shot 2021-11-24 at 9 51 23 PM" src="https://user-images.githubusercontent.com/2036040/143311263-e568b9b2-8a56-4d20-8421-893d17c02f87.png">

This can then be committed with `git commit` as follows:

<img width="699" alt="Screen Shot 2021-11-24 at 9 52 55 PM" src="https://user-images.githubusercontent.com/2036040/143311422-f3d8dd14-ac45-45df-a6f8-25d294f1a9d0.png">

Other changes during the build stage might require adding or removing a patch Electron is floating - instructions for this can be found in [Electron's patch system guide](https://github.com/electron/electron/blob/main/docs/development/patches.md).

This progressive build process continues until `e build` finishes running successfully.

An example of changes from previous rolls can be found [here](https://github.com/electron/electron/pull/31317).

### Test Debugging Stage

TODO

## FAQ

TODO