---
action:
 - add 'blocked/need-repro' label
---

## If No Repro Included

Thanks for reporting this and helping to make Electron better!

Would it be possible for you to make a standalone testcase with only the code necessary to reproduce the issue? [Electron Fiddle](https://www.electronjs.org/fiddle) is a great tool for making small testcases and publishing them as [gists](https://gist.github.com) that Electron maintainers can use.

If the bug you've found can be tested with a pass / fail test, please make the testcase [exit 0 on success or nonzero on failure](https://github.com/electron/bugbot#by-bug-reporters). The lets [Electron's issue bot](https://github.com/electron/bugbot#readme) see what releases are affected by the bug by checking your test against different OSes and Electron versions.

I'm adding the `blocked/need-repro` label for this reason. After you make a test case, please link to it in a followup comment.

Thanks in advance! Your help is appreciated.



## If Repro Requires Third-Party Tooling

Thanks for reporting this and helping to make Electron better!

Because of time constraints, triaging code with third-party dependencies is usually not feasible for a small team like Electron's. Would it be possible for you to make a standalone testcase with only the code necessary to reproduce the issue? [Electron Fiddle](https://www.electronjs.org/fiddle) is a great tool for making small testcases and publishing them as [gists](https://gist.github.com) that Electron maintainers can use.

If the bug you've found can be tested with a pass/fail test, please make the testcase [exit 0 on success or nonzero on failure](https://github.com/electron/bugbot#by-bug-reporters). The lets [Electron's issue bot](https://github.com/electron/bugbot#readme) see what releases are affected by the bug by checking your test against different OSes and Electron versions.

I'm adding the `blocked/need-repro` label for this reason. After you make a test case, please link to it in a followup comment.

Thanks in advance! Your help is appreciated.
