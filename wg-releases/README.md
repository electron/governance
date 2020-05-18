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
| <img src="https://github.com/vertedinde.png" width=100 alt="@vertedinde">  | Keeley Hammond [@VerteDinde](https://github.com/vertedinde) | Member | PT (Portland) |

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

## Feature Backport Requests
Backporting non-breaking features to supported versions requires the approval of the Releases Working Group.  Any feature PR that is targeting branch(es) other than master should be labeled with a `pending-vote 🗳` label.  The approval process will work as follows:
1. By requesting backport of a feature, the submitter of the PR is assuming responsibility for this feature on the requested branches.  If a backport PR causes any breakage, it may be removed if the PR submitter does not fix the breakage.
2. All issues labeled as `pending-vote 🗳` will be reviewed during the Releases Working Group weekly meeting.  Alternatively, the Releases Working Group may vote for issues asynchronously for requests that need a quicker response.
3. Backport requests require that at least 3 working group members from at least 2 different companies approve the request.  If the submitter of the request is a member of the Release working group they may be one of the 3 approvers.  If at least 3 working group members have approved the request and there are no objections from other members, the request will be immediately approved once 3 members have approved.  If there is not unanimous approval of the feature, a majority of the Working Group will be required to approve the request.  Due to the distributed nature of the Releases WG, a backport request that doesn't have consensus may take longer to be approved or rejected until all available members can weigh in.
4. Once a backport request has been approved the PR will be labeled with the approved branches (eg `bp-9-x-y-approved`).

Please note that during our quiet period during our [Final Beta Release](https://github.com/electron/governance/blob/master/wg-releases/major-release-process.md#final-beta-release), we will not accept feature backports to the beta release.
