# Joining Electron Governance

This documents the process for becoming a member of Electron Governance. Being a member of Electron Governance means you are actively a member of at least one Working Group.

## Requirements

* A new member is approved by their prospective Working Group according to their rules for membership. Approval is recorded in meeting notes.
* A new member has a GitHub account
* A new member is a guest on Electron's Slack

## Steps

After all the requirements above are completed, follow these steps below to add a new member to Electron Governance.

1. Submit the Workflow form for "New Governance Member" in #wg-community-safety channel. Typically the current WG chair will submit this.

2. Update the Working Group README file to include the new member. Typically the current WG chair will submit this.

3. An [Electron GitHub owner](./permissions.md#organization-owners) invites the new member to the Electron Org in GitHub. New member needs to accept this to continue the process.

4. A Slack admin will invite the new member to #access-request channel. New member requests a Google account through the "Request @electronjs.org" shortcut in #access-request Slack channel.

5. Approve the Google account request and provide the account to the new member. A Google Suite account is required to sign in to Electron's services (e.g., Slack, GitHub, etc). See full [details on GSuite permissions](./permissions.md#gsuite).
    - Current owners of GSuite set up are @MarshallOfSound and @codebytere.

6. Submit a pull request to add the new member's GitHub handle under the approved Working Group in the `config.yaml` file in [.permissions repo](https://github.com/electron/.permissions/).

7. A member of [Community & Safety WG](https://github.com/electron/governance/tree/master/wg-community-safety#membership) adds an approval review the PR in .permissions repo. Typically the current WG chair will submit this.

8. Merge .permissions PR. This final step will automatically add the new member to:
    * The WG's team on GitHub
    * The WG's user group on Slack
    * Update the new member's Slack access to full member
