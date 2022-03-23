# Electron Issues Triage

Triaging issues in Electron allows maintainers to more quickly parse context and determine if a given issue is an issue that should be prioritized. It also allows for more effectively determining who has requisite context to solve a given issue.

Issue triage is not an exact science, but the following general rules are helpful to keep in mind when working to triage.

## Check Basics

**Is this an issue at all?**

If the issue is a question about a module in Electron or a request to help an opener solve a bug in their own code, the issue tracker is not currently the appropriate forum for this. As such, issues of this nature should be closed:

> Thanks for reaching out!

> Because we treat our issues list as the team's backlog, we close issues that are questions since they don't represent a task needing to be completed. For most questions about Electron there are a lot of options. 

> Check out the [Electron community](https://github.com/electron/electron#community). There are also a bunch of helpful people in this [community forum](https://discuss.atom.io/c/electron) that should be willing to point you in the right direction.

**Has the issue opener ignored the template?**

If they have, that issue should be marked with the `blocked` label and more information should be requested. The following provides a typical response we may give in that case, but you may adapt it to your needs:

> We require the template to be filled out on all new issues and pull requests. We do this so that we can be certain we have all the information we need to address your submission efficiently. This allows the maintainers to spend more time fixing bugs, implementing enhancements, and reviewing and merging pull requests.

> We will be able to more closely look at your issue once you do so. This issue will be closed in 10 days if the above is not addressed.

If the opener has filled out the template but omitted key aspects of it, like the platform or Electron version, this is also the suitable template to use. You may also add a bit of extra information to it specifying what exactly they omitted from the template and why it is important.

**Apply Basic Labels** 

From the information provided in the template, important labels to add include:

For Bugs:
* Operating Systems: `platform/all`, `platform/win`, `platform/mac`, `platform/linux`
* Version(s): `{version}-x-y` (i.e. `20-x-y`)
* Incomplete report: `blocked/needs-repro`, `blocked/needs-info`
* Actionable repro: `has-repro-gist`, `has-repro-repo`
* Reviewed by another maintainer: `status/reviewed`, `status/confirmed`
* Urgency: `regression`, `crash`

For Features
* The `enhancement` label
* Operating System (if applicable)

There are also a series of `component` labels touching different subsystems of Electron. If for example the opener is reporting a new bug or requesting a new feature for the `menu` module, it would also be appropriate to apply the `component/menu` label. Not all subsystems have labels - you may make new ones or omit the component at your discretion.

**Is the version still supported?**

If the version of Electron a bug is being reported if still a supported version per [current policy](https://www.electronjs.org/docs/tutorial/support)? If not, it is appropriate to mark as `blocked` here as well, and request that the bug be tested on a supported version before it can be triaged. A reply that may be appropriate here is:

> The version of Electron you reported this on, [VERSION], has been superseded by newer releases -- the latest in that series is [NEWEST_VERSION]. In order for us to be able to triage this issue, it must be reproducible on a a supported release line. If it cannot be reproduced in a supported line, this issue will be closed

> I'm setting the more-information-needed label for the above reasons. After you've responded, please @ me in a followup comment. 

> Thanks in advance! Your help is appreciated.

**What version labels should I add if the issue originates well past supported versions?**

If you know the version of Electron where the issue began, add that version label. If you don't know when the issue began, but it is still affecting the latest version, add all of the current supported version labels.

The `main` label is generally reserved for A) urgent issues that are currently blocking the `main` branch, or B) issues that are present in main, but in no alpha, beta or stable versions of Electron. If the issue exists in any alpha, beta or stable version, that latest version should be used instead of main.

## Check Reproducible Steps

As the issue triager, it is not your responsibility to confirm whether or not an issue is reproducible based on a provided sample unless you so choose. We just want to confirm that one has been provided. Ideally, the user will provide a Fiddle Gist link or a link to a repo we may clone down. 

Some reporters will provide a small snippet without context, and if you can, we would like to avoid that. If you do not think you could reasonable determine how to run an Electron instance from the provided sample, or there is no sample, it would be appropriate to request a more thorough repro:

> Please provide a standalone test that a tester could run to reproduce the issue. This makes fixing issues go more smoothly: not only does it ensure the right thing is tested, but it also prevents triage from bottlenecking on making testers write new tests for each new issue.

> I'm setting the more-information-needed label for the above reasons. After you've responded, please @ me in a followup comment.

> Thanks in advance! Your help is appreciated.

## Common Responses

This section outlines several common scenarios, and the responses and labels we recommend using for issue triage. It also tries to address several commonly asked questions for those new to the issue triage process.

_NB: The reponses below are meant to be a guide for someone new to triaging issues in Electron, not requirements. If you find an issue while triaging that you think needs a different response than is recommended here, use your own judgement._

#### Low Quality/Spam

Issue did not fill out the issue template:
  * Reply with [`issue-template` response](https://github.com/electron/governance/blob/main/wg-releases/issue-playbook/fill-template.md)
  * Add `blocked/needs-info` label

Issue is asking about a third-party dependency, or app-specific JavaScript code
  * Reply with `send-to-discord` response
  * Close the issue

Issue is transparently spam
  * Close the issue (no reply needed)

#### Blocked/Needs Info

Issue does not contain adequate information (i.e., no expected behavior or is on an older version of Electron):
  * Reply with [`please-test-newer` response](https://github.com/electron/governance/blob/main/wg-releases/issue-playbook/please-test-newer.md), or ask for clarification on missing information
  * Add `blocked/needs-info` label

Issue has no repro:
  * Reply with [`needs-repro` response](https://github.com/electron/governance/blob/main/wg-releases/issue-playbook/needs-repro.md)
  * Add `blocked/needs-repro` label

### Has Repro

Issue does contain enough information and has a repro, but you as a triager don't have time to confirm the repro:
  * Add `has-repro-gist` or `has-repro-repo` label
  * Add `platform/*` for the affected OS (Mac/Windows/Linux/All)
  * Add `status/reviewed` label

Issue can be reproduced!
  * Add `status/confirmed` label
  * Add `platform/*` for the affected OS (Mac/Windows/Linux/All) if not added
  * If the issue affects a new version of Electron, add it to the Project Board for the **newest** affected version (i.e. if both 17-x-y and 18-x-y are affected, add it to the 18-x-y Project Board).

### Crash Report

Issue details a crash, but has no repro or crash report attached:
  * Reply with [`crash-report` response](https://github.com/electron/governance/blob/main/wg-releases/issue-playbook/needs-repro.md)
  * Add `blocked/needs-info` label
  * Add `crash` label

Issue details a crash and has a crash report attached, but no repro:
  * Add `crash` label
  * Try running the .dmp file or report through `electron-minidump` or `electron-symbolicate`. If the crash is only a stacktrace, or if you find you need more symbol information, reply with [`crash-report` response](https://github.com/electron/governance/blob/main/wg-releases/issue-playbook/needs-repro.md)
  * Add `status/reviewed` label

Issue details a crash, and has both a crash report and a repro:
  * Add `crash` label 
  * Add `has-repro-gist` or `has-repro-repo` label
  * Review the repro gist. If the crash can be reproduced, add `status/confirmed` label

## Other Playbook Responses

As situations arise, you may also consult the [issue playbook](./issue-playbook) for responses which are not covered here.
