## Releasing Electron

Electron's Release process is performed using a Slack-based bot system called Sudowoodo, which lives [here](https://github.com/electron/sudowoodo).

### Running Sudowoodo

Only authorized releasers have the ability to trigger Sudowoodo, and they can be seen and verified by running `/sudowoodo-trainers` from within Electron's Slack workspace.

In order to trigger a new release:

1. Invoke `/sudowoodo` as a backslash command in the `#bot-releases` Slack channel.
2. Choose the correct release branch (`main`, `5-0-x`, etc.) and release type (`stable`, `beta`, `nightly`) from the dropdown in the resulting dialog.
3. Monitor the resulting release until builds are finished and Sudowoodo is preparing to publish the new release to npm
4. Enter the OTP needed to publish the builds to npm (similarly gated to `sudowoodo-trainers`)
5. Celebrate 🎉

### Troubleshooting Sudowoodo

Sometimes Sudowoodo hits roadblocks and can't complete the release on its own. In nearly all cases, these roadblocks fall into one of a small number of categories.

1. CircleCI timeouts

    * **Symptoms**
      * Sudowoodo fails due to "Build waiter failed"
      * Check the build that it failed to wait for and see whether it was a command time out
    * **How to fix**
      * This happens sometimes as a result of failures of CircleCI infrastructure that cause builds to be rerun within their containers.
      * Sudowoodo has built-in resilience to this.
      * Should this occur, the release process can be continued by invoking `/blasting-off-again {COMMIT_HASH}` as a backslash command in `#bot-releases`.

2. GitHub Asset Upload Failure

    * **Symptoms**
      * Sudowoodo fails due to "Build waiter failed"
      * Check the build that it failed to wait for and see whether it failed during "upload to github" with `HTTP Error 422` "Unprocessable Entity".
    * **How to fix**
      * Owing to a long-standing bug in GitHub's asset upload code, assets can become corrupted such that the assets fail to upload but exist as strange ghost assets, such that they cannot be deleted or re-uploaded.
        * These ghost assets can be deleted from the UI: you can go to the draft release, delete the ghost assets (marked with a red question mark) and then re-run just the single build that failed to upload.
        * The release process can then be continued by invoking `/blasting-off-again {COMMIT_HASH}` as a backslash command in `#bot-releases`

3. Sudowoodo fails after all builds have been completed

    * **Symptoms**
      * Sudowoodo fails and the logs in Slack clearly show "Build Completed"
      * Check the logs in Papertrail to determine the actual cause of failure if it is not clear from the logs visible in Slack
    * **How to fix**
      * This might be because of a failure in later scripts
      * Should this occur, the release process can be continued by invoking `/blasting-off-again {COMMIT_HASH}` as a backslash command in `#bot-releases`.
      * Do not run `/blasting-off-again` blindly in this scenario; instead check the papertrail logs accessible through Heroku and do not continue until you know what went wrong.
        * If you are unsure please ping `@releases-wg` for debugging assistance.
    * In some of these cases Sudowoodo itself will wait and ask you if you want to retry a certain release step.
      * For example, the `publish to npm` step is infinitely retryable through a slack button.
