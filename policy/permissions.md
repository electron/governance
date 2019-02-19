# Permissions

> The goal of this document is to strictly outline the permissions that members
> of governance will receive on certain services depending on their role

## GitHub

### Organization Owners

All "Electrocats" (Hubbers working on Electron) are granted Organization "Owner"
permissions along with the directors of the following Working Groups.

* Releases WG
* Security WG
* Community & Safety WG
* Administrative WG

This list of WG's can be adjusted and presently excludes Working Group's whose scope is
limited to a very small subset of repositories or don't need access to organization
level settings / actions.

### Repository Administrators

All Working Group Directors are granted "Admin" permissions to the repositories
that their group is deemed responsible for.  This is documented in the
`repos.md` file in each `wg-*` directory in this Governance repository.

### Repository Write Access

All active members of Governance are granted "Write" permissions to all
**public** `electron/*` repositories with the following exceptions:

* [`electron/electron`](https://github.com/electron/electron)
* [`electron/trop`](https://github.com/electron/trop)
* [`electron/nightlies`](https://github.com/electron/nightlies)
* [`electron/archaeologist`](https://github.com/electron/nightlies)
* [`electron/debian-sysroot-image-creator`](https://github.com/electron/debian-sysroot-image-creator)
* [`electron/update.electronjs.org`](https://github.com/electron/update.electronjs.org)

All Working Group Members are granted "Write" permissions to the **private**
repositories that their group is deemed responsible for.  This is documented in
the `repos.md` file in each `wg-*` directory in this Governance repository.

Although "Write" access may be granted to the repository this does **not**
implicitly grant `master` / Protected Branch rights.  They should be determined
by the Working Group that owns each repository but as a general policy, all
repositories should have their `master` branch set as a Protected Branch.

### Repository Read Access

Repositories in the Electron Organization are public/open-source by default.
Read access should never have to be granted explicitly to a repository.

## Slack

### Full Users

All active members of Governance will have a full-access Slack account on
Electron HQ.

### Multi-Channel Guests

Currently no requirement.  If a requirement for this arises either propose an
amendment here, or propose an Exception (detailed below).

### Single Channel Gusts

In a variety of situations, some users may be added as Single Channel Guests to
the Electron HQ Slack.

* People attending Mini-Summit's or Hackweeks should be added as single-channel
guests to the related `mini-summit-*`/`hack-week-*` channel.
* Members of the AFP should be added as single-channel guests to the
`#app-feedback-program` channel.

## Exception

From time to time we may find a need to make exceptions to the above rules for
a variety of reasons.  In the situation where it is not appropriate to amend
the rules rather make a one-off exception you must list it below along with
the reasoning for the exception.  Exceptions can only be granted by unanimous
vote of the Administrative Working Group.

| Name | GitHub Username | Permission Granted | Reason |
|------|-----------------|--------------------|--------|