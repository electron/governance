# ElectronHQ Slack Workspace

The people working on Electron organize their work using Slack, a "hub for teamwork".
Even if you've worked with Slack before, it might be a good idea to review some of the guidelines
about what's considered good etiquette in our workspace.

## Guidelines

### Mentions: `@here` and `@channel`

Slack allows users to ping everyone present in a channel using three groups: `@here` for all
active members in a channel and `@channel` for everyone in a channel. While we haven't disabled those
groups, _do not use them unless absolutely necessary_. Push notifications are the equivalent of
texting someone. Only use `@`-mentions with exactly the people you _need to reach_.

* Do not use **@here** or **@channel** in channels with more than 10 users – and then only if you want to reach all those people.

### Channel Names

Slack uses channels to organize work into "chat rooms". You can read more about Slack channels and
[how to use them here](https://slack.com/resources/using-slack/how-to-organize-your-slack-channels).
In order to organize channels, we're using _prefixes_. We recommend that you consider using one when
creating new channels:

* `announce-`: Announcement channels, not used for general chatter – and excellent for following along.
* `bot-`: Channels used by bots and apps, like `#bot-twitter` or `#bot-electron-repo`.
* `devel-`: Channels for evergreen Electron development topics, like `#devel-linux` or `#devel-fiddle`.
* `proj-`: Timeboxed project-specific channels, like `#proj-protect-the-supply-chain`.
* `idea-`: Channels for projects that aren't quite a project yet, but worthy of their own channel.
* `wg-`: Channels for governance working groups.
* `event-`: Channels for individual events.
* `app-`: Channels for specific apps, like `#app-slack`.

### Prefer Channels, Avoid Direct Messages

Keeping communication and decision-making processes allows future contributors to learn how, and why,
decisions were made. Preserving context and allowing other contributors, both future and present,
to catch up is one of the big benefits of using Slack. With that in mind, we heavily recommend that
you use channels and avoid direct messages.

### Private Slack Channels

Private channels are discouraged unless there is a clear need, e.g. for sensitive information such
as discussion of vulnerability reports.

### Shared Slack Channels

For communicating with larger groups of [collaborators](../../../charter/README.md#definitions) from
external companies sometimes it is more appropriate to create a single shared channel than it is to
invite everyone individually as a guest.

All shared channels should be public and have to be approved by a Slack Owner before they can be
linked. If a shared private channel needs to be created, a reason should be provided when requesting
the channel.

## Access

### Owners

All members of the Administrative Working Group shall be granted the "Owner" role in Slack.

Certain members of the Infrastructure Working Group can be granted the "Owner" role in Slack.
Adding members of the Infrastructure Working Group as owners requires a vote from the Administrative Working Group.

Current infra owners are listed below:

| Name | Slack Handle | Date Granted |
|------|-----------------|--------------|
| Shelley Vohr | @codebytere | 09-28-2022 |
| Samuel Attard | @marshallofsound | 09-28-2022 |

Slack requires a single Primary Owner, who will be selected by the Admin WG.
[Samuel Attard](https://github.com/marshallofsound) is the current Primary Owner of the ElectronHQ workspace.

### Admins

All members of the [Community & Safety Working Group](../wg-community-safety/README.md) have the
"Admin" role in Slack.

### Members

All [maintainers](../../../charter/README.md#definitions) shall have a full-access Slack account on Electron HQ.

### Guests

All Multi-Channel and Single-Channel Guests must fill out the [ElectronHQ Slack Maintainer Group form](https://electronjs.org/maintainers/join)
before gaining Slack access. Once this form is filled out, the [Community & Safety Working Group](../wg-community-safety/README.md)
will review the request. If the request is approved, the guest will be added to the applicable channel(s).

Before a Guest is added to a channel, a message must be posted to that channel stating the intent to
add that guest to the channel after 24 hours and asking for concerns to be raised. Every channel
member must have 24 hours to raise concerns about the guest being added to the channel regardless
of timezone. After 24 hours without any concerns raised, the guest may be added to the channel.
It must be announced in the channel that the guest was added to ensure that all current members are
aware a new guest is now in that channel.