# Security WG Membership & Notifications

## Membership

Due to the Security Working Group's sensitive role in responding to newly-reported vulnerabilities, membership is limited. The group has made a conscious decision to restrict initial exposure to only those who will contribute to fixes.

### Application Process

To join the Security WG, apply by notifying the group. The WG will vote at the next meeting, with results recorded only as "accepted" or "not accepted" (individual votes remain private).

### Evaluation Criteria

When voting, members consider whether the applicant has shown a history of Electron maintenance indicating they could contribute to fixing security issues:

- Do they have a history of commits to Electron?
- Have they worked constructively with other maintainers?

Applicants whose applications are declined are encouraged to continue collaborating with maintainers, landing PRs, and participating in other Working Groups before reapplying in the future.

## Notifications

### Need-to-Know Notifications

These are limited-information advance warnings about upcoming releases. Depending on sensitivity and availability, they may include:

- Affected versions
- Affected platforms
- Possible mitigations

**Example:**
> A new security vulnerability has been confirmed affecting Electron 3.0 and above on all platforms. A new release to fix this is expected within the next week.

**Purpose:** To help Electron-based apps plan so they can deliver security fixes to users as quickly as possible.

**Access:** Made via a private Slack channel on ElectronHQ. Contact the Security WG to join.

**Confidentiality:** These notifications are confidential. Particupants may share the information only with the minimum number of employees required to ship or evaluate a fix. Use private channels only, and do not mention security issues in release notes until public notification occurs. Leaking information may result in revoked access to protect program integrity.

### Public Notifications

Public notifications provide broader disclosure of vulnerabilities, including:

- Affected features
- Mitigation strategies
- How the vulnerability was discovered

These announcements typically accompany new releases that fix the issue.

**Where to find announcements:**
- `#announce-security` in [ElectronHQ Slack](https://electronjs.org/maintainers/join)
- Electron's [GHSA Feed](https://github.com/electron/electron/security)
- [Electron blog](https://electronjs.org/blog)