# Permissions

> The goal of this document is to strictly outline the permissions that members of governance will receive on certain services depending on their role

## GitHub

### Organization Owners

The Chair of the Administrative Working Group is always an Organization Owner. Every other user is granted ownership based on a need-focused approval process.

All approved owners should be listed below:

| Name | GitHub Username | Date Granted |
|------|-----------------|--------------|

Adding and removing people from this list requires good reasoning and a vote from the Administrative Working Group. If you wish to request an addition / removal from this list please fill out this [Google Form]().  The Administrative Working Group shall vote on the request at the next meeting and record the outcome in their meeting notes.  If the request is approved a member of the Administrative Working Group should make a pull request to this file to update the above list.

### Repository Administrators

There is currently no direct-grant of "Admin" permissions for repositories.  If you need to perform a task that requires Admin permissions please mention the @github-owners Slack user-group and one of those users will perform the request if appropriate.

### Repository Write Access

All active members of Governance are granted "Write" permissions to all
**public** `electron/*` repositories with the following exceptions:

* [`electron/electron`](https://github.com/electron/electron)
* [`electron/trop`](https://github.com/electron/trop)
* [`electron/nightlies`](https://github.com/electron/nightlies)
* [`electron/archaeologist`](https://github.com/electron/nightlies)
* [`electron/debian-sysroot-image-creator`](https://github.com/electron/debian-sysroot-image-creator)
* [`electron/update.electronjs.org`](https://github.com/electron/update.electronjs.org)
* [`electron/fiddle`](https://github.com/electron/fiddle)

All Working Group Members are granted "Write" permissions to the **private** repositories that their group is responsible for, and the working group can decide on access to nonmembers. This is documented in the `repos.md` file in each `wg-*` directory in this Governance repository.

Although "Write" access may be granted to the repository this does **not** implicitly grant `master` / Protected Branch rights. They should be determined by the Working Group that owns each repository but as a general policy, all repositories should have their `master` branch set as a Protected Branch.

If a repository has multiple Working Group stakeholders, access will be determined by a vote from the chairs of _all_ working groups. Any chair may abstain.  The vote must be at least 2/3 of participating chairs.

### Repository Read Access

Repositories in the Electron Organization are public / open-source by default. Read access should never have to be granted explicitly to a repository.

## Slack

### Slack Owners / Admins

Due to current Slack requirements [Jacob Groundwater](https://github.com/groundwater) is the Primary Owner of the Slack Workspace. Every other user is granted ownership based on a need-focused approval process.

All approved owners should be listed below:

| Name | Slack Username | Date Granted |
|------|----------------|--------------|

Adding and removing people from this list requires good reasoning and a vote from the Community & Safety Working Group. If you wish to request an addition / removal from this list please fill out this [Google Form]().  The Community & Safety Working Group shall vote on the request at the next meeting and record the outcome in their meeting notes.  If the request is approved a member of the Community & Safety Working Group should make a pull request to this file to update the above list.

### Full Users

All active members of Governance will have a full-access Slack account on Electron HQ.

### Multi-Channel / Single-Channel Guests

In a variety of situations, some users may be added as Guests to the Electron HQ Slack.

* People attending Mini-Summits or Hackweeks should be added as single-channel guests to the related `mini-summit-*`/`hack-week-*` channel.
* Members of the AFP should be added as single-channel guests to the
`#app-feedback-program` channel.

Before a Guest is added to a channel it should be announced in that channel to ensure that all current members are aware a guest is now in that channel.  As only Slack Owners can invite guests it is their responsibility to ensure that all members of a given channel are ok with the addition of a guest.

### Private Slack Channels

Private channels are discouraged without a clear need, e.g. the security email channel.

## Twitter

The Outreach Working Group owns access controls for social media accounts, e.g. the @ElectronJS Twitter account.

## Exceptions

Exceptions to these rules may sometimes be necessary. When it's appropriate to make one-off exceptions rather than amending the rules, you must list it below along with the reasoning for the exception. Exceptions can only be granted by vote of the directors of _all_ working groups. 

| Name | GitHub Username | Permission Granted | Reason |
|------|-----------------|--------------------|--------|
