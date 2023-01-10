# Upgrade Duty Guide

The Upgrades WG has the important task of ensuring Electron stays up-to-date with Chromium. To achieve this, members of the Upgrades WG take turns being on Upgrade Duty where they spend a week working on updating our dependencies, resolving build errors, running tests and ensuring they pass, debugging failures, signaling for review on the upgrade, and addressing any review comments left by other members. After a member finishes their term on Upgrade Duty, their work transfers to the next member in the rotation and they pick up wherever the last member left off, be it on a fresh upgrade batch or in the middle of the last batch.

There's a lot of nuance and skill that goes into this giant process. As such, we believe that no member should have to learn how to navigate through it all on their own. The rest of the WG is

This guide is meant to help new (and seasoned) members figure out the methods and tools we have built up as a group over time to efficiently succeed at our work. We will cover the overall process of the Upgrade Cycle and what it means to be on Upgrade Duty, as well as common flows and things to look out for within each step of the Upgrade Cycle.

## Editor's Note

Every person has their own unique workflow quirks and ways of doing things that makes sense to them, and we love that! We embrace whatever helps you get the job done well. 😊

This guide serves not as a prescription for how you must do things, but rather
as a compass if you get lost or need help finding where to start. And if you can't find an answer here, always feel free to ask in channel (#wg-upgrades or #ask-anything) for pointers.

I hope this guide helps you solve an issue or work through a task!

Good luck! ❤️ 👍

# The Upgrade Cycle & Upgrade Duty

The Upgrade Cycle can be thought of as four big steps:

<!-- TODO: diagram of the upgrade cycle -->

1. **Sync**: Ensuring our updated dependencies still sync and that the patches we maintain over our dependencies still apply correctly.
2. **Build**: Fixing errors due to build configuration changes and code API changes.
3. **Test**: Running our automated test suite and CI to detect and fix runtime crashes, errors, and bugs from upgrading our dependencies.
4. **Review**: Reviewing each other's commits, addressing comments and suggestions, and sometimes tracking new work that needs to be done in followup.

# Step 1: Sync

The sync step is all about our dependencies—Chromium, v8, Node.js, and all the rest—and making sure we can still fetch them and that the patches we maintain still apply cleanly to them. A big chunk of this step is automated to help keep upgrade work moving forward and to reduce repetitive tasks. I'll make note of what parts are 🤖 _automated_ as we go through the process.

Most upgrades start with a commit that bumps up the version of Chromium we depend on. The version of Chromium we upgrade to depends on the version of Electron we're doing the upgrade for. The `main` branch might get the most recent version of Chromium, whereas a previous supported release may upgrade but stay on the same major version of Chromium.

> 🤖 _Automated_: Rollerbot 🛼 (Chromium version bump PRs)
>
> The [`electron-rollerbot`](https://github.com/apps/electron-roller) automation automatically opens PRs that upgrade the Chromium version we depend on. Along with creating PRs targeting the `main` branch to use the latest Chromium version, the rollerbot also opens PRs for supported version branches (`1-x-y`, `2-x-y`, ...) upgrading them to the latest Chromium version that is appropriate for that version of Electron.
>
> On top of opening PRs, the rollerbot will also keep bumping the Chromium version in its PRs so that upgrades PRs don't go stale while we work on them. This continuous update can be paused by adding the `roller/pause` label to the rollerbot PR.
<!-- TODO: image of rollerbot PR here  -->

Other upgrades work also includes upgrading our other dependencies, like Node.js. We don't have much in terms of automation for these relatively rarer upgrade PRs.

After bumping the Chromium version, we can sync all of Chromium's dependencies. This part of the upgrade cycle is called "sync" after the command `e sync` which initially calls `gclient sync`. That command has to do with upgrading the dependencies of Electron (mostly Chromium and its dependencies) or fetching them if they aren't already there. The fetching/upgrading part of the sync rarely runs into any problems.

One of the final parts of the sync is patching. In Electron we maintain patches to our dependencies that allow us to interface with them properly. When we upgrade our dependencies, those patches need to still apply cleanly and correctly. This is where most manual work often happens for this part of the upgrades cycle.

## Commit Etiquette

... todo

## Patch Conflicts

After incrementing the version of Chromium we depend on, the patches we maintain may not apply correctly anymore. This is a very common occurrence! You might see output sort of like this:

```
error: patch failed: [...]/render_widget_host_view_base.h:26
error: [...]/render_widget_host_view_base.h: patch does not apply
Patch failed at 0009 render_widget_host_view_base.patch
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
Traceback (most recent call last):
  File "[...]/src/electron/script/apply_all_patches.py", line 35, in <module>
    main()
  [...]
```

<details>
<summary><em>Why does this happen?</em></summary>

... todo

---

</details>

Here's the rundown of the approach we usually take for solving patch conflicts:

0. (Reset your chromium checkout if you need to by aborting the `git-am` session: <br/> `git am --abort`)
1. Apply the patches as a three-way merge: <br/> `e sync --3`
2. Fix patch conflicts as merge conflicts, resuming the `git-am` session: <br/> `git am --continue`
3. Export changes to patches: <br/> `e patches chromium` (etc.)
4. Re-sync with the fixed patches: <br/> `e sync`
5. Sometimes, export other patch changes: <br/> `e patches [...]`
6. Commit the fixed patches: <br/> `git commit`

Before redoing the sync, you might want to go and reset your git state back to before the `git-am` command ran. In the root of your Chromium checkout (the directory `electron/` is in, with Chromium code like `base/` and `content/`) abort the `git-am` session:

```shell
# In the Chromium checkout:
$ git am --abort
```

The easiest way to resolve this issue is by doing a three-way merge. This situation is so common that `build-tools` makes this extremely simple for you:

```shell
$ e sync --3
```

This will apply the patches as a three-way merge, stopping when there's a merge conflict. You can now resolve this conflict like any regular merge conflict, then resume the `git-am` session:

```shell
# After resolving a merge conflict
# In the Chromium checkout:
$ git am --continue
```

After all the patches have successfully applied, there's one last important step: **export the patch changes**. After resolving patch conflicts, export the changes to the patch files like you would any other patch:

```shell
# After all patches apply
$ e patches chromium
```

You must export the fixed patches so you can do a full proper sync with them:

```shell
# After exporting fixed patches
$ e sync
```

Finally, you can make a commit to the Electron checkout including all changes to the patches files. We usually refer to this as fixing up the patch indices (as that is usually all that changes), but sometimes the actual code in the patch changes and you should call that out in your commit.

Sometimes, when committing your patch changes you will run into a pre-commit check we have setup to ensure that when the patches change, all patches match up with the outer Chromium checkout.

```shell
# Git pre-commit error message, for example:
[...]
Patches in src/electron/patches/v8 not up to date: 5 patches need update
[...]

# To resolve, in this case:
$ e patches v8
```

Now you can stage those new patch changes and commit your patch update.

🎉 And with that, you have resolved patch conflicts! Congrats! 👏

# Step 2: Build

... todo

## Commit Etiquette

... todo

## Build Failures Outside of `electron/`

... todo

# Step 3: Test

... todo

# Step 4: Review

... todo

# Troubleshooting

... todo
