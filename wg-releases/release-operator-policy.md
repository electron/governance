# Release Operators

A Release Operator is a member of Electron governance who is authorized to perform management actions on [Sudowoodo](sudowoodo.md): manually queueing releases, retrying steps, cancelling or cleaning up steps, and creating release branches.

Entering the npm 2FA/OTP code during a release is not gated by this policy. Any member of the Releases Working Group may continue to do that, unchanged.

## Prerequisites

A Release Operator shall be an active member of Electron governance, meaning a member of at least one Working Group.

## Granting

Any member of the Releases Working Group may nominate a governance member (including themselves) to become a Release Operator.

Approval requires a super-majority vote of the Releases Working Group: at least 2/3 of the full sitting membership must vote in favor. A reasonable effort should be made to collect votes asynchronously from members who cannot attend the meeting, per the [Charter](../charter/README.md).

The vote and its outcome shall be recorded in the Releases Working Group [meeting notes](meeting-notes).

## Revoking

Release Operator status is revoked:

* Automatically, when the member leaves Electron governance.
* Together with removal from the Releases Working Group under the existing [WG Removal Policy](README.md#wg-removal-policy), unless the Working Group explicitly votes to retain it.
* At any time, by the same 2/3 super-majority vote of the full sitting membership. No cause is required; this is a risk-mitigation lever, not a judgement.

In response to suspected account compromise, misuse, or another security concern, any member of the [Infrastructure WG](../wg-infra/README.md) may immediately remove a Release Operator from the `release-operators` team, revoking their Sudowoodo access. The removal takes effect immediately and shall be reported to the Releases Working Group within 24 hours. The Releases Working Group then either ratifies the removal or reinstates the member via the normal vote.

## Enforcement

The set of Release Operators is mirrored as the `release-operators` GitHub team, managed in [electron/.permissions](https://github.com/electron/.permissions). Sudowoodo resolves that team to gate management actions.

After any grant or revoke vote, the team shall be updated within 7 days and verified by running `/sudowoodo-trainers` in Slack.

## Initial Membership

The people holding the management-action privilege when this policy was adopted — members of both the Releases Working Group and `mergers` at the time this document merged — are grandfathered in as the initial Release Operators, ratified by the merging of the pull request that introduced this document:

* [@ckerr](https://github.com/ckerr)
* [@codebytere](https://github.com/codebytere)
* [@dsanders11](https://github.com/dsanders11)
* [@jkleinsc](https://github.com/jkleinsc)
* [@MarshallOfSound](https://github.com/MarshallOfSound)
* [@VerteDinde](https://github.com/VerteDinde)
