# Releases WG

Oversees all release branches, and tooling to support releases.

## Membership

| Avatar | Name | Role | Time Zone |
| -------------------------------------------|----------------------|----------------------------| -------- |
| <img src="https://github.com/codebytere.png" width=100 alt="@codebytere">  | Shelley Vohr [@codebytere](https://github.com/codebytere) | **Chair** | CET (Berlin) |
| <img src="https://github.com/jkleinsc.png" width=100 alt="@jkleinsc">  | John Kleinschmidt [@jkleinsc](https://github.com/jkleinsc) | Member | ET (Harrisburg) |
| <img src="https://github.com/ckerr.png" width=100 alt="@ckerr">  | Charles Kerr [@ckerr](https://github.com/ckerr) | Member | CT (New Orleans) |
| <img src="https://github.com/vertedinde.png" width=100 alt="@vertedinde">  | Keeley Hammond [@VerteDinde](https://github.com/vertedinde) | Member | PT (Portland) |
| <img src="https://github.com/deepak1556.png" width=100 alt="@deepak1556">  | Deepak Mohan [@deepak1556](https://github.com/deepak1556) | Member | PT (Vancouver) |
| <img src="https://github.com/sofianguy.png" width=100 alt="@sofianguy">  | Sofia Nguy [@sofianguy](https://github.com/sofianguy) | Member | PT (San Francisco) |
| <img src="https://github.com/zcbenz.png" width=100 alt="@zcbenz">  | Cheng Zhao [@zcbenz](https://github.com/zcbenz) | Member | JST (Nagoya) |
| <img src="https://github.com/marshallofsound.png" width=100 alt="@marshallofsound">  | Samuel Attard [@MarshallOfSound](https://github.com/marshallofsound) | Member | PT (Vancouver) |
| <img src="https://github.com/mlaurencin.png" width=100 alt="@mlaurencin">  | Michaela Laurencin [@mlaurencin](https://github.com/mlaurencin) | Member | PT (Seattle) |
| <img src="https://github.com/clavin.png" width=100 alt="@clavin">  | Calvin Watford [@clavin](https://github.com/clavin) | Member | MT (Salt Lake City) |

## Current Objective and Key Results

**Objective:** Save expensive human time by offloading work to inexpensive computers.

**Key Results:**
* Reduce time-to-first-green, and time-to-all-greens in development.
* Reduce number of times tests need to be re-run.
* Reduce time to generate and deploy release builds.

## Areas of Responsibility

* Releasing Electron according to schedule
* Release timeline coordination
  * When to cut new branches for major release lines (e.g. `11-x-y`)
  * Planning beta cycles, timelines, etc.
  * Listening and responding to feedback
* Management of Heroku apps for [associated repositories](#associated-repositories)
* Triaging issues and organizing beta stabilization issues for discussion.
* Determining which [features](feature-backport-requests.md) are allowed to be backported to release lines.

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

1. Regularly attend three meetings
2. Request entry into Releases Working Group by asking the current Chair
3. Obtain consensus approval by vote of existing membership during a portion of a meeting which the requester shall not attend.

## WG Removal Policy

If a sitting member of the WG has not been active in a meaningful way for at least one month, the WG may vote to remove them from its set of sitting members.

This is done primarily to ensure that there are no open avenues of compromise for the project given that the Releases WG confers notable permissions.

## Meeting Schedule

* **Sync Meeting** 1 hour each Wednesday, alternating between two times: [16:30 UTC](https://duckduckgo.com/?q=16%3A30+UTC&ia=answer) and [23:00 UTC](https://duckduckgo.com/?q=23%3A00+UTC&ia=answer).

Meeting notes may be viewed in [meeting-notes](meeting-notes).

## Current Objective and Key Results

**Objective:**

Reduce frustrations of major app consumers

**Key Results:**

* Lower the number of regressions experienced in major release lines.	
* Reduce time to discovering regressions in major release lines.
* Increase number of apps testing against the major release line in beta.
* Improved quality and quantity of communication around release-related information.

**Objective:**

Save expensive humans time

**Key Results:**

* Make a person’s worth of time appear.
