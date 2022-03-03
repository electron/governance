## If No Repro Included

Thanks for reporting this and helping to make Electron better!

Please use [Electron Fiddle](https://github.com/electron/fiddle) to create a standalone (no external dependencies) testcase and publish it as a [gist](https://gist.github.com), then link to it here.

- Even if you have a code snippet or a git repository that show the testcase, please put it in a gist. This lets maintainers triage issues more effectively. It also ensures that we're testing the exact same issue that you're seeing!

- Please avoid external dependencies in the test. The Electron team is small and generally doesn't have enough bandwidth to triage third-party code. Also, standalone tests are easier to adapt into regression tests.

- If the bug you've found can be tested with a pass / fail test, please make the testcase [exit 0 on success or nonzero on failure](https://github.com/electron/bugbot#by-bug-reporters). The lets [Electron's issue bot](https://github.com/electron/bugbot#readme) see what releases are affected by the bug.

I'm adding the `blocked/need-repro` label for this reason. After you make a test case, please link to the gist in a followup comment.

Thanks in advance! Your help is appreciated.
