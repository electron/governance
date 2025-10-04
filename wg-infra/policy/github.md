# GitHub Repositories

## Maintainer Access

Maintainer access to GitHub resources is governed by the [GitHub access policy](./access/github.md).

## Repository Properties

Electron utilizes [custom properties](https://docs.github.com/en/organizations/managing-organization-settings/managing-custom-properties-for-repositories-in-your-organization#about-custom-properties) to label repositories such that certain policies can apply to various kinds of repository. These properties are set and configured via the [`.permissions`](https://github.com/electron/.permissions) repo.

### `owning-working-groups`

This property maps to a list, but typically a single working group that "owns" a given repository. This allows us to ping the correct working group when issues arise and route things correctly.

### `security-level`

This property maps to one of the following security levels:

* **Unreleased Open:** Used for repositories that are prototypes, have not been released yet, typically these repositories are not even public. Using this security level requires #wg-infra or #wg-security approval.
* **Secure Defaults:** Used for the majority of repositories, this setting will automatically enable various branch protections, repo settings and access policies that ensure the security of the Electron ecosystem.
* **Locked Down:** Used for our most secure repositories, this setting is an extension of "Secure Defaults" but it limits merge rights to a specific group of people.

## Repository Security

### Commit Signing

All commits in the Electron Enterprise **must** be signed, either via SSH or GPG. This is an org-wide required check. Fork PRs will be unable to merge and direct pushes will be rejected if your commits are not signed.

### Branch Protections

The `default_branch` of every repository in the Electron Enterprise that is flagged as "Secure Defaults" or higher will have the following branch protections applied:

* Restrict Deletions
* Require linear history
* Require pull request before merging
  * Require reviews from Code Owners
  * Required Approvals: 1
  * Allowed merge methods: Squash
* Block force pushes

The `default_branch` of every repository in the Electron Enterprise that is flagged as "Locked Down" or higher will have an additional branch protection added limiting "update" access to a subset of users (unlisted here intentionally).

## Exceptions

Exceptions to the above policy can be requested in #wg-infra and current exceptions are recorded outside of this repository.
