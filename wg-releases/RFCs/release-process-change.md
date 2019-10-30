# RFC: Release Process Change

**Author:** Shelley Vohr

## What We Do Now

Right now, we create a new branch for every new minor release line. For example, there current exist branches for `4-0-x`, `4-1-x`, and as of recently, `4-2-x`.

Every new minor release branch supersedes the previous one, but the branches remain, both in our branching structure and in Sudowoodo.

## The New Process

Moving forward, I propose we only maintain one staging branch for every major release line. This would mean (for example) removing `4-0-x`, `4-1-x`, and `4-2-x` in favor of one unified `4-x-y`.

All semver-minor features, as they already are today, must be approved by the Releases WG before being backported into any given stabilization line. Then, when a new release is run from that line,  it would be released as a a minor or patch depending on whether there were unreleased semver-minor commits in the branch.

Security releases would be released as patches on top of the latest minor version on a given branch.

This would remove confusion around issues in backporting and simplify and streamline the process as a whole.

Finally, this should in no way change the ratio of patch to minor releases or increase the frequency of minor releases: the same level of care and high bar is required for any new semver-minor commits to land on a given stabilization branch.

**Nota Bene:** This change would also necessitate changes to release-associated tooling to account for new branching structure, including but not necessarily limited to our version bump scripts & Sudowoodo.
