# ElectronHQ Slack Workspace

The people working on Electron organize their work using Slack, a "hub for teamwork".
Even if you've worked with Slack before, it might be a good idea to review some of the guidelines
about what's considered good etiquette in our workspace.

## Access

For details on Slack access (e.g. member roles and inviting new guests), see the
[Infrastructure WG policy document](../wg-infra/policy/access/slack.md).

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

Private channels are discouraged unless there is a clear need (e.g. for sensitive information such
as discussion of vulnerability reports).

### Shared Slack Channels

For communicating with larger groups of [collaborators](../../../charter/README.md#definitions) from
external companies sometimes it is more appropriate to create a single shared channel than it is to
invite everyone individually as a guest.

All shared channels should be public and have to be approved by a Slack Owner before they can be
linked. If a shared private channel needs to be created, a reason should be provided when requesting
the channel.
