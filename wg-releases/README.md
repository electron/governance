# Releases WG

Oversees all release branches, and tooling to support releases.

## Membership

| Avatar | Name | Role | Time Zone |
| -------------------------------------------|----------------------|----------------------------| -------- |
| <img src="https://github.com/codebytere.png" width=100 alt="@codebytere">  | Shelley Vohr [@codebytere](https://github.com/codebytere) | **Chair** | PT (San Francisco) |
| <img src="https://github.com/jkleinsc.png" width=100 alt="@jkleinsc">  | John Kleinschmidt [@jkleinsc](https://github.com/jkleinsc) | Member | ET (Harrisburg) |
| <img src="https://github.com/ckerr.png" width=100 alt="@ckerr">  | Charles Kerr [@ckerr](https://github.com/ckerr) | Member | CT (New Orleans) |
| <img src="https://github.com/marshallofsound.png" width=100 alt="@marshallofsound">  | Samuel Attard [@MarshallOfSound](https://github.com/marshallofsound) | Member | PT (Vancouver) |
| <img src="https://github.com/deepak1556.png" width=100 alt="@deepak1556">  | Deepak Mohan [@deepak1556](https://github.com/deepak1556) | Member | PT (Vancouver) |
| <img src="https://github.com/sofianguy.png" width=100 alt="@sofianguy">  | Sofia Nguy [@sofianguy](https://github.com/sofianguy) | Member | PT (San Francisco) |
| <img src="https://github.com/zcbenz.png" width=100 alt="@zcbenz">  | Cheng Zhao [@zcbenz](https://github.com/zcbenz) | Member | JST (Nagoya) |

## Current Objective and Key Results

**Objective:** Save expensive human time by offloading work to inexpensive computers.

**Key Results:**
* Reduce time-to-first-green, and time-to-all-greens in development.
* Reduce number of times tests need to be re-run.
* Reduce time to generate and deploy release builds.

## Areas of Responsibility

* Releasing Electron according to schedule
* Release timeline coordination
  * When to cut new branches for major and minor release lines (e.g. `v3.0` -> `v3.1`)
  * Planning beta cycles, timelines, etc.
  * Listening and responding to feedback
* Management of Heroku apps for [associated repositories](#associated-repositories)

## Leadership Responsibilities

In addition to responsibilities outlined in the [Charter](../charter/README.md), a Chair of the Releases Working Group should:

* Run regular release audits for [supported branches](https://electronjs.org/docs/tutorial/support#supported-versions) using [`unreleased`](https://github.com/electron/unreleased).
  * Check for unmerged backports and pull requests needing manual (non-[trop](https://github.com/electron/trop)) backports to release branches.
* Ensure releases are run for supported branches passing the pre-set unreleased commit threshold.
* Ensure relevant PRs are being backported to necessary branches, and that original PR openers are opening manual backports for those that trop is unable to handle itself.

## Associated Repositories

See [repos.md](repos.md)

## Rules for Membership

In order to join the Releases Working Group, an aspiring member must:

1. Attend three consecutive meetings
2. Request entry into Releases Working Group by asking the current Chair
3. Obtain consensus approval by vote of existing membership during a portion of a meeting which the requester shall not attend.

## WG Removal Policy

If a sitting member of the WG has not been active in a meaningful way for at least one month, the WG may vote to remove them from its set of sitting members.

This is done primarily to ensure that there are no open avenues of compromise for the project given that the Releases WG confers notable permissions.

## Meeting Schedule

* **Sync Meeting** 45 min every Wednesday at [23:00 UTC](https://duckduckgo.com/?q=23%3A00+UTC&ia=answer)
* **Major Release Cadence Meeting** 1 hour every Thursday at [00:00AM UTC](https://duckduckgo.com/?q=00%3A00+UTC&ia=answer)

Meeting notes may be viewed in [meeting-notes](meeting-notes).

## Feature Backport Requests for Major Versions in Beta

With our 12-week major release cadence, we are _not_ considering feature backport requests after the Releases WG meeting of Week 3 of each beta cycle. Backport requests after Week 3 will only be considered if there is a very good reason. For backport requests please submit the link to the PR and reason for backport to the Releases WG agenda for consideration.
