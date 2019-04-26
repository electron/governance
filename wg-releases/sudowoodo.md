## Releasing Electron

Electron's Release process is performed using a Slack-based bot system called Sudowoodo, which lives [here](https://github.com/electron/sudowoodo).

### Running Sudowoodo

Only authorized releasers have the ability to trigger Sudowoodo, and they can be seen and verified by running `/sudowoodo-trainers` from within Electron's Slack workspace.

In order to trigger a new release:

1. Invoke `/sudowoodo` as a backslack command in the `#bot-releases` Slack channel.
2. Choose the correct release branch (`master`, `5-0-x`, etc.) and release type (`stable`, `beta`, `nightly`) from the dropdown in the resulting dialog.
3. Monitor the resulting release until builds are finished and Sudowoodo is preparing to publish the new release to npm
4. Enter the OTP needed to publish the builds to npm (similarly gated to `sudowoodo-trainers`)
5. Celebrate 🎉

### Troubleshooting Sudowoodo

Sometimes Sudowoodo hits roadblocks and can't complete the release on its own. In nearly all cases, these roadblocks fall into one of a small number of categories.

1. CircleCI timeouts
**Symptoms**
  * Sudowoodo fails due to "Build waiter failed"
  * Check the build that it failed to wait for and see whether it was a command time out
**How to fix**
  * This happens sometimes as a result of failures of CircleCI infrastructure that cause builds to be rerun within their containers. 
  * Sudowoodo has built-in resilience to this.
  * Should this occur, the release process can be continued by invoking `/blasting-off-again {COMMIT_HASH}` as a backslash command in `#bot-releases`.
2. GitHub Asset Upload Failure
  * Owing to a long-standing bug in GitHub's asset upload code, assets can become corrupted such that the assets fail to upload but exist as strange ghost assets, such that they cannot be deleted or re-uploaded.
  * Unfortunately, the only solution in these cases is to clean up the build and re-trigger a new one.
3. Sudowoodo fails after all builds have been completed
  * This might be because of a failure in later scripts
  * Should this occur, the release process can be continued by invoking `/blasting-off-again {COMMIT_HASH}` as a backslash command in `#bot-releases`.
