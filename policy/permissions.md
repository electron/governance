# Permissions

> The goal of this document is to strictly outline the permissions that maintainers will receive on certain services depending on their roles.

## GitHub

### Organization Owners

Maintainers are granted ownership based on a need-focused approval process.

All approved owners shall be listed below:

| Name | GitHub Username | Date Granted |
|------|-----------------|--------------|

Adding and removing people from this list requires good reasoning and a vote from the Administrative Working Group. If you wish to request a change to this list please follow the process outlined in the [Administrative Working Group Documentation](../wg-administrative/github-ownership-access.md).  If the request is approved a member of the Administrative Working Group shall make a pull request to this file to update the above list.

### Repository Administrators

There is currently no direct-grant of "Admin" permissions for repositories.  If you need to perform a task that requires Admin permissions please mention the @github-owners Slack user-group and one of those users will perform the request if appropriate.

### Repository Write Access

All [maintainers](../charter.md#definitions) are granted "Write" permissions to all
**public** `electron/*` repositories with the following exceptions:

* [`electron/archaeologist`](https://github.com/electron/archaeologist)
* [`electron/debian-sysroot-image-creator`](https://github.com/electron/debian-sysroot-image-creator)
* [`electron/electron`](https://github.com/electron/electron)
* [`electron/fiddle`](https://github.com/electron/fiddle)
* [`electron/nightlies`](https://github.com/electron/nightlies)
* [`electron/trop`](https://github.com/electron/trop)
* [`electron/update.electronjs.org`](https://github.com/electron/update.electronjs.org)

All Working Group Members are granted "Write" permissions to the **private** repositories that their group is responsible for, and the working group can decide on access to nonmembers. This is documented in the `repos.md` file in each `wg-*` directory in this Governance repository.

Although "Write" access may be granted to the repository this does **not** implicitly grant `master` / Protected Branch rights. They shall be determined by the Working Group that owns each repository but as a general policy, all repositories should have their `master` branch set as a Protected Branch.

If a repository has multiple Working Group stakeholders, access will be determined by a vote from the chairs of _all_ working groups. Any chair may abstain.  The vote must be at least 2/3 of participating chairs.

### Repository Read Access

Repositories in the Electron Organization should be public / open-source by default. Read access should never have to be granted explicitly to a repository.  Some sensitive repositories can be private but they must have a good reason for being kept private.

## Slack

### Slack Owners / Admins

Slack requires a single Primary Owner, who will be selected by the Admin WG. [Jacob Groundwater](https://github.com/groundwater) is the current Primary Owner of the Slack Workspace.

Slack Owners / Admins are assigned as per the [Community & Safety Working Group Documentation](../wg-community-safety/slack-access.md)

### Full Users

All [maintainers](../charter.md#definitions) shall have a full-access Slack account on Electron HQ.

### Multi-Channel / Single-Channel Guests

In a variety of situations, some [collaborators](../charter.md#definitions) may be added as Guests to the Electron HQ Slack.  The exact process for requesting guest access for yourself or another collaborator is detailed in the [Community & Safety Working Group Documentation](../wg-community-safety/slack-access.md).

* People attending Mini-Summits or Hackweeks should be added as single-channel guests to the related `event-*` channel.
* Members of the AFP should be added as single-channel guests to the
`#app-feedback-program` channel.

Before a Guest is added to a channel it must be announced in that channel to ensure that all current members are aware a guest is now in that channel.  As only Slack Owners can invite guests it is their responsibility to ensure that all members of a given channel are ok with the addition of a guest.

### Private Slack Channels

Private channels are discouraged unless there is a clear need, e.g. for sensitive information such as discussion of vulnerability reports.

## Twitter

The Twitter account is currently owned by GitHub and access is managed by them.  In the future we'd like for this account to be owned by the Outreach Working Group.

## Exceptions

Exceptions to these rules may sometimes be necessary. When it's appropriate to make one-off exceptions rather than amending the rules, you must list it below along with the reasoning for the exception. Exceptions can only be granted by vote of the chairs of _all_ working groups. 

| Name | GitHub Username | Permission Granted | Reason |
|------|-----------------|--------------------|--------|
