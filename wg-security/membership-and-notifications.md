# Security WG Membership & Notifications

## Membership

Due to the Security Working Group's sensitive role in responding to newly-reported vulnerabilities, membership on this Working Group is limited. The group has made a conscious decision to limit initial exposure to only those who will contribute to the fix.

People who want to join the Security WG should apply by notifying the WG, which will then vote at the next meeting. The vote shall be recorded only as "was accepted" or "was not accepted" rather than how each member voted.

When voting, members should consider: has the person shown a history of Electron maintenance that indicates they could contribute to the fixing of security issues? For example, do they have a history of commits to Electron? Have they worked with other maintainers in a constructive way?

Based on that criteria, the WG encourages people whose applications were declined to continue collaborating with other maintainers, to continue landing PRs, to participate in other Working Groups, and to re-apply in the future.

## Notifications

### Need To Know

These notifications are limited-information advance warnings that say that a new release is coming and, depending on the sensitivity and availability of invitation, _perhaps_ some of the following:

* affected versions
* affected platforms
* possible mitigations

For example:

> A new security vulnerability has been confirmed that affects Electron 3.0 and above on all platforms. A new release to fix this is expected in the next week.

The intent of these is to help Electron-based apps do short-term planning so that they can get security fixes to their users as soon as possible.

These notifications will be made via a private Slack channel on ElectronHQ. If you'd like to join this channel, please contact the Security WG.

### Public Notifications

Public notifications are a wider disclosure of vulnerabilities. Unlike the "Need To Know" notifications, these will give some information about the vulnerability, e.g. what features are affected, mitigation strategies, and how the vulnerability was discovered.

These announcements will typically be made alongside new releases which fix the issue.

Places to look for these announcements:

* `#announce-security` in [ElectronHQ Slack](https://electronjs.org/maintainers/join)
* Electron's [Twitter](https://twitter.com/electronjs) account
* https://electronjs.org/blog
