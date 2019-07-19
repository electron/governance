# Major Release Process

This document outlines the major release stable promotion process.

## Final Beta Release

One week before stable promotion for a given release line, we should release a final beta with ideally few changes. This means that for a stable release date of Tuesday, we should be releasing a final beta the friday a full > 1 week preceding that Tuesday, to allow for a quiet period week to account for complications.

Before releasing the final beta, we need to ensure that there remain no unmerged pull requests targeting that branch. This entails two tasks:

1) Run `/check-unmerged <branch-name>` in Slack and see if any PRs are returned
2) Check open PRs to `master` on `electron/electron` and ensure that none of them carry the label `target/<branch-name>`

If both tasks are complete, proceed with the final beta release.

## Communications Preparation

We need to ensure the following have owners and have been completed:

1) Blog Post
  * This post should contain the following:
    * An update for which versions are now supported, and the new types of support for each of those (security-only, etc.)
    * Link to timeline for subsequent major release
    * A list of breaking changes in the current stable line
    * References to any upcoming notable changes or deprecations
2) Tweet - a tweet about the latest stable line & blog post from the official `@electronjs` twitter account
3) Updates to [Supported Versions](https://github.com/electron/electron/blob/master/docs/tutorial/support.md#currently-supported-versions)
4) Timeline for subsequent [major release version](https://electronjs.org/docs/tutorial/electron-timelines)

## Stable Release Promotion

The day before the publicly communicated date, we should begin the stable promotion process. This is to account for errors with processes out of our control, like CI errors or errors on npm.

At approximately noon on that preceding day, a member of the Releases WG should trigger a release with Sudowoodo with the following parameters:

```sh
Release Branch: Stabilization Line (ie `6-0-x`)
Release Type: `Stable`
```

## Immediately Following Release

Immediately following the release, we need to ensure the following:

1) The [Electron Website](https://electronjs.org) reflects the latest stable version
2) The `latest` tag on npm correctly reflects the new latest major release line
3) The blog post has been successfully published to the [Electron Website](https://electronjs.org)

## New Stable Preparations

After a new major line has been officially stabilized, we should begin to prepare for the beta process of the next line.

For this, we need to ensure the following:

1) We have a new Node Module Version (NMV) for the line that follows what is about to become the new `master` major.
  * If we've just released `v6.0.0`, this means that `7-0-x` is about to become the beta line, and so we would need to procure a NMV for `8-0-x`.
2) Sudowoodo is capable of handling betas for the new major line.
