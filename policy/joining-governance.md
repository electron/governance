# Joining Electron Governance

This documents the process for becoming a member of Electron Governance. Being a member of Electron Governance means you are actively a member of at least one Working Group.

## Requirements

* A new member is approved by their prospective Working Group according to their rules for membership. Approval is recorded in meeting notes.
* A new member has a GitHub account
* A new member is a guest on Electron's Slack

## Steps

After all the requirements above are completed, follow these steps below to add a new member to Electron Governance.

1. A governance member (typically the WG Chair) submits the Workflow form for "New Governance Member" in `#wg-community-safety` channel.
  * The [Community & Safety WG](../wg-community-safety/README.md#membership) must then approve the request.

2. A governance member (typically the WG Chair) updates the Working Group README file to include the new member.

3. An [Electron GitHub owner](./permissions.md#organization-owners) invites the new member to the Electron Org in GitHub.
  * The new member needs to accept this invite in order to continue the onboarding process

4. A [Slack admin](../wg-community-safety/README.md#membership) invites the new member to `#access-request` channel.

5. The new member requests a GSuite account through the "Request @electronjs.org" shortcut in #access-request Slack channel.

6. A GSuite admin approves the request and updates the member's account on Slack with their new `@electronjs.org` email

6. A GSuite admin provide details for the new account to the new member.

7. A governance member (typically the WG Chair) submits a pull request to add the new member's GitHub handle under the approved Working Group in the `config.yaml` file in [.permissions repo](https://github.com/electron/.permissions/).
  * A member of [Community & Safety WG](../wg-community-safety/README.md#membership) must approve the PR.

8. Merge `.permissions` PR.
  * This final step will utilize [Sheriff](https://github.com/electron/sheriff) automatically add the new member to:
    * The WG's team on GitHub
    * The WG's user group on Slack
    * Update the new member's Slack access to Full Member


### Notes

* Current owners of GSuite set up are [@MarshallOfSound](https://github.com/MarshallOfSound) and [@codebytere](https://github.com/codebytere).
* A GSuite account is required to sign in to Electron's services (e.g., Slack, GitHub, etc).
    * See full [details on GSuite permissions](./permissions.md#gsuite).
