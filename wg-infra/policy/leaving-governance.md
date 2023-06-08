# Leaving Electron Governance

This documents the process of leaving Electron Governance. A contributor is no longer in Electron Governance if they are no longer a member of any Working Group.

## Offboarding Items

1. A governance member (Typically the WG Chair) update README file in [governance](https://github.com/electron/governance) for the WG the member is leaving.

2. A governance member (Typically the WG Chair) submits a PR in [.permissions repo](https://github.com/electron/.permissions/).
    * Merging this PR will automatically remove the contributor from:
      * The WG's team on GitHub
      * The WG's user group on Slack

3. Reset the former member's Slack account email to a personal email.

4. A Slack Admin demotes the member's account from Full Member to Multi-Channel Guest
    * Message in `#wg-community-safety` to request this.
    * Any member of Community & Safety WG is a Slack admin.
    * A demoted MCG has access to `#random`, `#ask-anything`, and in certain circumstances other channels by WG vote.  By default, all non-guest channels should be removed from their channel list to keep those spaces safe.

5. Message in `#access-requests` that the contributor has left Electron Governance.

6. Disable the former member's GSuite account
    * The account needs to be manually disabled, and 30 days later will be deleted.
      * See [details on GSuite permissions](./access/gsuite.md).

7. Remove the former member from the [Electron organization](https://github.com/electron/) on GitHub.
