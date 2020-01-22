# Upgrades WG

Oversees upgrades of upstream dependencies; specifically Chromium and Node.

## Membership

| Avatar | Name | Role | Time Zone |
| -------------------------------------------|----------------------|----------------------------| -------- |
| <img src="https://github.com/nornagon.png" width=100 alt="@nornagon">  | Jeremy Apthorp [@nornagon](https://github.com/nornagon) | **Chair** | PT (San Francisco) |
| <img src="https://github.com/alexeykuzmin.png" width=100 alt="@alexeykuzmin">  | Alexey Kuzmin [@alexeykuzmin](https://github.com/alexeykuzmin) | Member | CET (Prague) |
| <img src="https://github.com/deepak1556.png" width=100 alt="@deepak1556">  | Deepak Mohan [@deepak1556](https://github.com/deepak1556) | Member | ? |
| <img src="https://github.com/jkleinsc.png" width=100 alt="@jkleinsc">  | John Kleinschmidt [@jkleinsc](https://github.com/jkleinsc) | Member | ET (Harrisburg) |
| <img src="https://github.com/marshallofsound.png" width=100 alt="@marshallofsound">  | Samuel Attard [@MarshallOfSound](https://github.com/marshallofsound) | Member | PT (Vancouver) |
| <img src="https://github.com/codebytere.png" width=100 alt="@codebytere">  | Shelley Vohr [@codebytere](https://github.com/codebytere) | Member | PT (San Francisco) |
| <img src="https://github.com/loc.png" width=100 alt="@loc">  | Andy Locascio [@loc](https://github.com/loc) | Member | PT (San Francisco) |

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

* **Sync Meeting** 60 min every Tuesday @ [16:00 UTC](https://duckduckgo.com/?q=16%3A00+UTC&ia=answer)

Meeting notes may be viewed in [meeting-notes](meeting-notes).

## Joining the Upgrades WG

In order to become formal members of the WG, prospective members must:
1. be actively contributing to the work of the Upgrades WG,
2. attend 3 out of 6 consecutive meetings, and
3. be approved by a 2/3rds majority of current WG members (rounded up).
    1. The prospective member shall leave the meeting during the deliberation and vote.
    2. The meeting notes shall contain only the outcome of the vote (approved/not approved), not the individual votes.
    3. Members not able to attend the meeting at which the vote occurs may submit their vote to the Chair prior to the meeting.
    
If you're interested in joining the Upgrades Working Group, reach out to an [existing member](#Membership) and ask to be invited to the regular meeting and as a guest to the #wg-upgrades channel in Slack.

### Actively contributing

"Actively contributing" doesn't necessarily mean writing code, and it doesn't mean you have to be full-time on Electron Upgrades. It does mean that you should be in regular communication with the Upgrades WG (including attending meetings), and it does mean that you should be materially contributing to the project in some way. Some examples of actively contributing:

- You maintain a piece of code that integrates with Chromium (possibly including some patches), and it occasionally breaks during major Chromium upgrades. You don't write code every week, but you're available in the Slack channel to field questions about that component.
- You communicate regularly with the team maintaining one of Electron's dependencies, and help to coordinate releases and connect people on those teams to Electron. You don't write any code in Electron, but you help out reviewing the occasional PR.
- You help triage bugs reported on Electron's issue tracker related to Electron's dependencies. 

This is not an exhaustive list of ways you could be involved in the Upgrades WG. If you're not sure whether the Upgrades-related work you're doing counts as "actively contributing", reach out to a [member](#Membership) and ask. 🙂

### Timezones

The Upgrades WG currently meets only at 16:00 UTC because all current members are in timezones compatible with that meeting time. If you are unable to make that meeting time, let someone in the group know and we will switch to an alternating meeting schedule to accommodate all timezones.
