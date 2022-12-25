# Upgrades WG

Oversees upgrades of upstream dependencies; specifically Chromium and Node.

## Membership

| Avatar | Name | Role | Time Zone |
| -------------------------------------------|----------------------|----------------------------| -------- |
| <img src="https://github.com/jkleinsc.png" width=100 alt="@nornagon">  | John Kleinschmidt [@jkleinsc](https://github.com/jkleinsc) | **Chair** | EST (Harrisburg) |
| <img src="https://github.com/nornagon.png" width=100 alt="@nornagon">  | Jeremy Rose [@nornagon](https://github.com/nornagon) | Member | PST (San Francisco) |
| <img src="https://github.com/deepak1556.png" width=100 alt="@deepak1556">  | Deepak Mohan [@deepak1556](https://github.com/deepak1556) | Member | JST (Nagano) |
| <img src="https://github.com/codebytere.png" width=100 alt="@codebytere">  | Shelley Vohr [@codebytere](https://github.com/codebytere) | Member | CET (Berlin) |
| <img src="https://github.com/marshallofsound.png" width=100 alt="@marshallofsound">  | Samuel Attard [@MarshallOfSound](https://github.com/marshallofsound) | Member | PST (Vancouver) |
| <img src="https://github.com/ckerr.png" width=100 alt="@ckerr">  | Charles Kerr [@ckerr](https://github.com/ckerr) | Member | CST (New Orleans) |
| <img src="https://github.com/clavin.png" width=100 alt="@clavin">  | Calvin Watford [@clavin](https://github.com/clavin) | Member | MST (Salt Lake City) |
| <img src="https://github.com/VerteDinde.png" width=100 alt="@VerteDinde">  | Keeley Hammond [@VerteDinde](https://github.com/VerteDinde) | Member | PST (Portland) |

## Areas of Responsibility

* Ensuring that Chromium and Node upgrades happen in a timely fashion
* Upgrade-related tooling such as patch scripts, roller-bot
* Advising on maintenance burden of feature support for Chromium features
* When an Electron feature depends on or heavily integrates with Chromium,
    the upgrades working group will be responsible for assessing ongoing
    maintenance burden.
* Upstreaming patches
* Adding/dropping dependencies
  * e.g. `native_mate`

## Associated Repositories

See [repos.md](repos.md)

## Meeting Schedule

* **Sync Meeting** 30 min monthly @ [16:00 UTC](https://duckduckgo.com/?q=16%3A00+UTC&ia=answer)

Meeting notes may be viewed in [meeting-notes](meeting-notes).

## Joining the Upgrades WG

In order to become formal members of the WG, prospective members must:
1. be actively contributing to the work of the Upgrades WG, and
2. be approved by a 2/3rds majority of current WG members (rounded up).
    1. The prospective member shall leave the meeting during the deliberation and vote.
    2. The meeting notes shall contain only the outcome of the vote (approved/not approved), not the individual votes.
    3. Members not able to attend the meeting at which the vote occurs may submit their vote to the Chair prior to the meeting.
    
If you're interested in joining the Upgrades Working Group, reach out to an [existing member](#membership) and ask to be invited to the regular meeting and as a guest to the #wg-upgrades channel in Slack.

### Actively contributing

"Actively contributing" doesn't necessarily mean writing code, and it doesn't mean you have to be full-time on Electron Upgrades. It does mean that you should be in regular communication with the Upgrades WG (including attending meetings), and it does mean that you should be materially contributing to the project in some way. Some examples of actively contributing:

- You maintain a piece of code that integrates with Chromium (possibly including some patches), and it occasionally breaks during major Chromium upgrades. You don't write code every week, but you're available in the Slack channel to field questions about that component.
- You communicate regularly with the team maintaining one of Electron's dependencies, and help to coordinate releases and connect people on those teams to Electron. You don't write any code in Electron, but you help out reviewing the occasional PR.
- You help triage bugs reported on Electron's issue tracker related to Electron's dependencies. 

This is not an exhaustive list of ways you could be involved in the Upgrades WG. If you're not sure whether the Upgrades-related work you're doing counts as "actively contributing", reach out to a [member](#membership) and ask. 🙂

## WG Removal Policy

If a sitting member of the WG has not been active in a meaningful way for at least one month, the WG may vote to remove them from its set of sitting members.

This is done primarily to ensure that there are no open avenues of compromise for the project given that the Upgrades WG confers notable permissions.

### Timezones

The Upgrades WG currently meets only at 16:00 UTC because all current members are in timezones compatible with that meeting time. If you are unable to make that meeting time, let someone in the group know and we will switch to an alternating meeting schedule to accommodate all timezones.
