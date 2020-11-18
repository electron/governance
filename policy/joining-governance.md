# Joining Electron Governance

This documents the process for becoming a member of Electron Governance. Being a member of Electron Governance means you are actively a member of at least one Working Group.

## Requirements

* A new member is approved by their prospective Working Group according to their rules for membership. Approval is recorded in meeting notes.
* A new member has a GitHub account
* A new member is a guest on Electron's Slack

## Steps

1. Submit a the Workflow form for "New Governance Member" in #wg-community-safety channel.

2. Update the Working Group README file to include the new member.

3. An Electron GitHub owner needs to invite the new member to the Electron Org in GitHub. New member needs to accept this.

4. Request a Google account through the "Request @electronjs.org" shortcut in #access-request Slack channel.

5. A Google account is provided to the new member.

6. Submit a pull request to add the new member's GitHub handle under the approved Working Group in the `config.yaml` file in [.permissions repo](https://github.com/electron/.permissions/) .

7. A member of Community & Safety WG approves the PR in .permissions repo.

8. Merge .permissions PR. This final step will automatically add the new member to:
    * The WG's team on GitHub
    * The WG's user group on Slack
    * Update the new member's Slack access to full member
