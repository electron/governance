# Interest Groups

Interest groups are a mechanism in Electron governance that allow individuals to provide input into specific categories of Electron development.  These groups would provide input into Electron development via the following processes:

* Reviewing [electron/electron](https://github.com/electron/electron) PRs that have relevance to the interest group.
* Creating and commenting on RFCs/Intent To Ship issues related to the interest group.

## Possible Interest Groups

* APIs
* Node/V8
* New Chromium feature implementation (eg push notifications)

## Membership

Membership into interest groups are open to anyone in the Electron Maintainers group in good standing.
Interest groups will be listed in this repository with a link for maintainers to fill out a form to join an interest group.

## Interest Group PR Workflow

1. When a PR is created, the template for the PR will include a link to the list of interest groups so that the PR creator has a list of group(s) to ask for review from.
2. When a PR affects one or more interest categories the submitter of the PR or a reviewer of a PR assigns the appropriate interest group teams as reviewer(s) for the PR.
3. Members of interest groups will be notified via GitHub notifications when a PR has a reviewer set to the interest group teams that member belongs to.
4. Interest group members provide feedback using the GitHub PR review process.  Members of affected Interest Groups who do not provide feedback will be considered to be providing implicit approval of the PR.
5. If there are conflicting opinions on the PR, the reviewers involved should seek to resolve the conflicts within the PR.
6. If resolution cannot be agreed upon in the PR, the issue can be raised for resolution using [Electron's conflict resolution process](./README.md#reaching-agreement)
7. The resolution/decision on the PR should be documented in the issue via a GitHub comment.

## Interest Group RFC/Intent To Ship Workflow

1. Any maintainer can create a RFC or Intent To Ship issue in the [electron/electron](https://github.com/electron/electron) repository.  These issues would be used to gather input on ideas (RFCs) and feedback on planned implementations (Intent To Ship).  When creating a RFC or Intent To Ship issue, the submitter should pick the proper issue template which will include a link to the list of interest groups so that the issue creator has a list of group(s) to ask for input from.
2. Once input has been solicited, it is the responsibility of Interest Group members to provide feedback in these issues.  Members of affected Interest Groups who do not provide feedback will be considered to be providing implicit approval of the issue.
3. If there are conflicting opinions on the issue, the maintainers involved should seek to resolve the conflicts within the issue.
4. If resolution cannot be agreed upon in the issue, the issue can be raised for resolution using [Electron's conflict resolution process](./README.md#reaching-agreement)
5. The resolution/decision on the issue should be documented in the issue via a GitHub comment.
