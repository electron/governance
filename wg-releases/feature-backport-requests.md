## Feature Backport Requests

Backporting non-breaking features to supported versions requires the approval of the Releases Working Group. Any feature PR that is targeting branch(es) other than `main` should be labeled with a `backport/requested 🗳` label.

The approval process works as follows:

1. By requesting backport of a feature, the submitter of the PR is assuming responsibility for this feature on the requested branches.

    * If a backport PR causes any breakage, it may be removed if the PR submitter does not fix the breakage.

2. All issues labeled as `backport/requested 🗳` will be reviewed during the Releases Working Group weekly meeting.

    * Alternatively, the Releases Working Group may vote for issues asynchronously for requests that need a quicker response.

3. Backport requests require that at least 3 working group members from at least 2 different companies approve the request.

    * If the submitter of the request is a member of the Release working group they may be one of the 3 approvers.
    * If at least 3 working group members have approved the request and there are no objections from other members, the request will be immediately approved once 3 members have approved.
    * If there is not unanimous approval of the feature, a majority of the Working Group will be required to approve the request.
    * Due to the distributed nature of the Releases WG, a backport request that doesn't have consensus may take longer to be approved or rejected until all available members can weigh in.

4. Once a backport request has been decided upon the PR will be labeled appropriately with either a `backport/approved ✅` or `backport/declined ❌` label.

Please note that during our quiet period during our [Final Beta Release](./major-release-process.md#final-beta-release), we will not accept feature backports to the major release line in beta.
