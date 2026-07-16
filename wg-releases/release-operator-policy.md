## Release Operator Policy

A **Release Operator** is a member of Electron governance who is authorized to perform management actions on [Sudowoodo](sudowoodo.md): manually queueing releases, retrying steps, cancelling or cleaning up steps, and creating release branches.

Entering the npm 2FA/OTP code during a release is **not** gated by this policy — any member of the Releases Working Group may do that, unchanged.

### Prerequisites

A Release Operator must be an active member of Electron governance, i.e. a member of at least one Working Group.

### Granting

1. Any member of the Releases Working Group may nominate a governance member (including themselves) to become a Release Operator.
2. Approval requires a super-majority vote of the Releases Working Group: at least 2/3 of the full sitting membership must vote in favor.
    * A reasonable effort must be made to collect votes asynchronously from members who cannot attend the meeting, per the [Charter](../charter/README.md).
3. The vote and its outcome are recorded in the Releases Working Group [meeting notes](meeting-notes).

### Revoking

Release Operator status is revoked:

1. Automatically, when the member leaves Electron governance.
2. Together with removal from the Releases Working Group under the existing [WG Removal Policy](README.md#wg-removal-policy), unless the Working Group explicitly votes to retain it.
3. At any time, by the same 2/3 super-majority vote of the full sitting membership. No cause is required — this is a risk-mitigation lever, not a judgement.

### Enforcement

The set of Release Operators is mirrored as the `release-operators` GitHub team, managed in [electron/.permissions](https://github.com/electron/.permissions). Sudowoodo resolves that team to gate management actions.

After any grant or revoke vote, the team must be updated within 7 days and verified via `/sudowoodo-trainers` in Slack.

### Initial Membership

As a grandfather clause, the people holding the management-action privilege at adoption — members of both the Releases Working Group and `mergers` at the time this policy merges — are the initial Release Operators, ratified by the merging of the pull request that introduced this document:

* [@ckerr](https://github.com/ckerr)
* [@codebytere](https://github.com/codebytere)
* [@dsanders11](https://github.com/dsanders11)
* [@jkleinsc](https://github.com/jkleinsc)
* [@MarshallOfSound](https://github.com/MarshallOfSound)
* [@VerteDinde](https://github.com/VerteDinde)

### Audit

Quarterly, the Releases Working Group Chair compares `/sudowoodo-trainers` (and the `release-operators` team) against the grants recorded in meeting notes, and records the result in the meeting notes. Discrepancies are corrected to match the recorded grants and investigated.
