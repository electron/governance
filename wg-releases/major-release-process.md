# Major Release Process

This document outlines the beta -> stable promotion process for a major release.

## Final Beta Release

One week before stable promotion for a given release line, we should release a final beta with ideally few changes. This means that for a stable release date of Tuesday, we should be releasing a final beta the Friday a full > 1 week preceding that Tuesday, to allow for a quiet period week to account for complications.

Before releasing the final beta, we need to ensure we have fixed all stable blocker items. Afterwards, we need to ensure that there remain no unmerged pull requests targeting that branch. This entails two tasks:

1) Run `/check-unmerged <branch-name>` in Slack and see if any PRs are returned
2) Check open PRs to `main` on `electron/electron` and ensure that none of them carry the label `target/<branch-name>`

If both tasks are complete, proceed with the final beta release.

## Stable Preparation

We need to ensure the following have owners and have been completed:

* Blog Post
  * This post should contain the following:
    * An update for which versions are now supported, and the new types of support for each of those (security-only, full support, etc.)
    * Link to timeline for subsequent major release
    * A list of breaking changes in the current stable line
    * References to any upcoming notable changes or deprecations
* Tweet - a tweet about the latest stable line & blog post from the official `@electronjs` twitter account
* Updates to [Supported Versions](https://github.com/electron/electron/blob/master/docs/tutorial/support.md#currently-supported-versions)
* Timeline for subsequent [major release version](https://electronjs.org/docs/tutorial/electron-timelines)
* [`node-abi`](https://github.com/lgeiger/node-abi) stable update
  * Ensure that ABI version information is added for the first new stable version (Ex. `v6.0.0`)
* [Spectron](https://github.com/electron-userland/spectron) update - a version of Spectron should be published compatible with the new stable release
* [Chromedriver](https://github.com/electron/chromedriver) update - a version of Chromedriver should be published compatible with the version of Chromium being shipped in the new stable version
* Release notes
  * Update stable version release notes with copyedited notes
  * Ensure the following:
    * Correct spelling, grammar, capitalization, etc.
    * Items are categorized and organized properly, e.g., in Fixes or Other Changes
    * Notes include the items merged after the last beta release
  * Example: [v6.0.0 release notes](https://github.com/electron/electron/releases/tag/v6.0.0)

## Stable Release Promotion

The day before the publicly communicated date, we should begin the stable promotion process. This is to account for errors with processes out of our control, like CI errors or errors on npm.

At approximately noon on that preceding day, a member of the Releases WG should trigger a release with Sudowoodo with the following parameters:

```sh
Release Branch: Stabilization Line (ie `6-0-x`)
Release Type: `Stable`
```

## Immediately Following Release

Immediately following the release, we need to ensure the following:

* The [Electron Website](https://electronjs.org) reflects the latest stable version
* The `latest` tag on npm correctly reflects the new latest major release line
* The blog post has been successfully published to the [Electron Website](https://electronjs.org)

## Subsequent Release Line Preparations

After a new major line has been officially stabilized, we should begin to prepare for the beta process of the next line.

For this, we need to ensure the following:

* We have a new Node Module Version (NMV) for the line that follows what is about to become the new `main` major
* Sudowoodo is capable of handling betas for the new major line in its [release options](https://github.com/electron/sudowoodo/blob/master/src/slack-manager.ts#L240-L265)
* [`node-abi`](https://github.com/lgeiger/node-abi) beta update
  * We should ensure that ABI version information is added for the first beta in the new major stabilization line
    * See [this PR](https://github.com/lgeiger/node-abi/pull/67) for an example

## Node Upgrades Policy

Patch upgrades of Node that contain significant security or bug fixes, and are submitted more than 2 weeks prior to a stable release date will be accepted into an Electron alpha or beta release branch.

Minor upgrades of Node that contain significant security or bug fixes, and are submitted more than 2 weeks prior to a stable release date will be accepted into an Electron alpha or beta release branch on a case-by-case basis. These requests will be reviewed and voted on by the Releases Working Group, to ensure minimal disruption for developers who may be consuming alpha or beta releases
