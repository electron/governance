# Release Captain

This document is a guide to being a Release Captain in the Releases Working Group.

## What is a release captain?

Electron's stable release cycle mirrors the Chromium release cadence. Chrome currently releases on an 8 week cadence ([you can view Chromium's schedule here](https://chromiumdash.appspot.com/schedule)).

As part of maintaining that release schedule, the Releases WG appoints a new "Release Captain" every 8 weeks. The Release Captain's primary role is to make sure each beta and stable release is released on schedule, and that all tasks supporting a given release are completed on time.

The link for the Release Captain Schedule can be found on the [rotation website here](https://rotation.electronjs.org/rotations/d865ef86-ad57-4430-b417-e1d560bd8f93).

## Rotation

Each Release Captain Rotation lasts ~8 weeks. All current members of the Releases Working Group have been added to the Release Captain rotation.

If you're not able to be the Release Captain during a specific period, or need others to cover your shift during specific weeks, post in the Releases WG Slack channel to find coverage. If you are unable to serve as the Release Captain during the period in which you're assigned, post in the Releases WG Slack channel and we'll change the existing rotation.

## Responsibilites

### Ongoing (Week 1-8)

* Review the current pre-release branch [project board][] for new items
* Ensure that all items that block stable release have assigned members
* Post a "go/no go" in the Releases Slack channel, to cancel a meeting if the [meeting agenda][] is empty
* Work through the [meeting agenda][] to address action items
  * Lead backport request voting process
  * Assign a person to handle backports
  * Address Questions/Comments/Ideas

### Start of Shift (Week 1)

* Clone the [project board][] (select "Draft issues will be copied if selected" checkmark)
  * ask an admin to make the board public
* Update all items in the "beta prep" and "stable prep" columns
  * This includes updating due dates, and adding any new items
* Make sure that the Releases WG Google Calendar is up to date with Stable & Beta dates

### Beta Prep (Week 3-4)

* At the Releases WG meeting, go through the [project board][] and ensure all beta prep items have owners
* Review new minor/feat PRs for any needed documentation updates
* Review Chromium and Electron release notes for any upcoming deprecations (OS, API, etc)
  * Check `BUILD.gn` in Chromium for details as well

### Beta Release (Week 4)

* Ensure the beta is released on time
  * In #bot-sudowoodo, go through the workflow to release the beta
  * If you are not a releaser, make sure that a releaser is assigned

### Stable Prep (Week 7)

* At the Releases WG meeting, go through the [project board][] and ensure all stable prep items have owners
* Follow up with owners as the due dates approach, to make sure they're completed.

### Stable Release (Week 8)

* Ensure the stable release is released on time
* Perform a hand-off with the next Release Captain
* Move any open or important items to the new pre-release branch [project board][].

### Questions?

If you have any questions, post in the Releases WG channel! While the Release Captain leads the release, they should never have to do a release alone - it's the responsibility of the entire working group. Always ask questions or ask for help if you need it.

<!-- Link labels -->

[project board]: https://github.com/orgs/electron/projects?query=is%3Aopen
[meeting agenda]: https://docs.google.com/document/d/1XWdD4uAu9m8Gcpiw1j5fLwwZ_hU4rce9JyTpuKU6uM8/edit#heading=h.lmqlihhhgcch
