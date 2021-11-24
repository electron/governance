# Upgrading Electron's Primary Dependencies

As a member of the Upgrades Working Group, you'll likely be part of the upgrades rotation, where 1-2 people
on duty work to upgrade Chromium and Node.js in Electron based on the release schedules of the upstream projects.

This guide lays out basic approaches to upgrading both Chromium and Node.js.

## Upgrading Chromium

1. Ensure you've fetched the latest information from upstream Electron.

```console
$ git fetch origin
```

2. Check out a local version of the Chromium upgrade branch.

```console
$ git checkout roller/chromium/main
```

3. Update and apply Electron's patches to the new version of Chromium.

```console
# The -3 argument runs patch application with three-way merge
$ e sync -3
```

It's likely that this initial step will fail - this is because Chromium has changed the code upstream that a given patch is altering and so git no longer understands where it should change the existing code.

To proceed from here, you'll need to fix each successive patch until `e sync` completes successfully.

When `e sync -3` stops on failure, you should be able to find in console the patch that caused the failure. Then, you should `cd` into the relevant directory, where you can then run `git status` to see what the patch conflicts are.

Now it's time to determine why the failure occurred. In this example, the patch failed on `pepper_isolated_file_system_message_filter.cc` - you'll want to open `pepper_plugin_support.patch` in a code editor and then open the corresponding upstream file in [Chromium's Code Search](`https://source.chromium.org/chromium`). From there, you can look at the file blame, as well as file history:

<img width="1400" alt="Screen Shot 2021-11-24 at 8 00 31 PM" src="https://user-images.githubusercontent.com/2036040/143298699-a430c1bf-54c6-49d5-bc4e-9d9d7ad69a1a.png">

Then, look at the blame and history to determine what change would have caused the patch application to fail. If you're lucky, Chromium will just have moved around a few lines of code or changed something that won't actually affect the change we're intending to make to it with our patch.

TODO: explain how to actually fix the patch in a way that is not terrifying

Continue this process with each successive patch until they're all successful and `e sync` finishes properly.

-- Keeley Edits/Scratchpad Below

### Fixing Patches: The Easy Way

Start by running `e sync --3`. As our scripts apply Electron's patches to its various dependency directories, you'll likely run into an error that looks like this: 

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

`cd` into the `src` directory and view the patch diff. If you're using a code editor like VSCode, you'll likely see an interactive diff like this:

<img width="850" alt="Screen Shot 2021-11-24 at 2 47 38 PM" src="https://user-images.githubusercontent.com/2036040/143304349-76aa846a-1f34-4d3b-a38c-de511e0d7f25.png">

Now it's time to determine why the failure occurred. In this example, the patch failed on `pepper_helper.h` - you'll want to open `pepper_plugin_support.patch` in a code editor and then open the corresponding upstream file in [Chromium's Code Search](`https://source.chromium.org/chromium`). From there, you can look at the file blame, as well as file history:

<img width="1400" alt="Screen Shot 2021-11-24 at 8 00 31 PM" src="https://user-images.githubusercontent.com/2036040/143298699-a430c1bf-54c6-49d5-bc4e-9d9d7ad69a1a.png">

Then, look at the blame and history to determine what change would have caused the patch application to fail. Oftentimes, Chromium will just have moved around a few lines of code or changed something that won't actually affect the change we're intending to make to it with our patch. Here, the diff indicates that Chromium removed `#include "base/compiler_specific.h"`. The patch just wants to add `#include "base/component_export.h"`, so the conflict can be resolved by removing the compiler include and adding the component export include.

Now, you can add the file (`git add chrome/renderer/pepper/pepper_helper.h`) and then continue with `git am --continue` until all conflicts are resolved.

### Fixing Patches: The Advanced Way

For most patches, as noted above, Chromium will just have moved around a few lines of code or changed something that won't actually affect the change we're intending to make to it with our patch.

Sometimes, however, Chromium will make changes that require a patch 

### Build Stage

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

and then stage and commit this file. It's important to let reviewers and other rotation members know why you made this change, so you should reference the CL in this commit to Electron. Each CL has a copy/pasteable string available, which can be found here:

<img width="1553" alt="Screen Shot 2021-11-24 at 9 51 23 PM" src="https://user-images.githubusercontent.com/2036040/143311263-e568b9b2-8a56-4d20-8421-893d17c02f87.png">

This can then be committed with `git commit` as follows:

<img width="699" alt="Screen Shot 2021-11-24 at 9 52 55 PM" src="https://user-images.githubusercontent.com/2036040/143311422-f3d8dd14-ac45-45df-a6f8-25d294f1a9d0.png">

This process continues until `e build` finishes running successfully.

### Manually fixing a patch during build stage

Sometimes during the `e build` step, you'll run into a patch issue, or need to manually update a patch. 

Updating Patches:

1. Find existing patch: `git log -p --grep "patch_name.patch"`
2. Apply the fixup: `git commit --fixup COMMIT_SHA`
3. Rebase: `git rebase --autosquash -i COMMIT_SHA^`