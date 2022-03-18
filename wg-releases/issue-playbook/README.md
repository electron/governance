# A Tactical Guide to Issue Triaging

In [our Issue Playbook](https://github.com/electron/governance/blob/main/playbooks/issue-triage.md#process), the Electron team outlines a guide to how we approach our issue tracker and the basic process for triaging issues.

This document is meant as a supplemental text for someone new to triaging issue. It outlines several common scenarios, and the responses and labels we recommend using for issue triage. It also tries to address several commonly asked questions for those new to the issue triage process.

## Common Responses

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


## FAQ

**What's the rough process I should follow when triaging issues?**

The process is outlined in [our Issue Playbook here (under "Process")](https://github.com/electron/governance/blob/main/playbooks/issue-triage.md#process).

**How should I use labels?**

We use labels to determine whether or not the issue has enough relevant information to let a maintainer move forward on fixing it. Specifically, the areas we look for are:

* Incomplete report: `blocked/needs-repro`, `blocked/needs-info`
* Actionable repro: `has-repro-gist`, `has-repro-repo`
* Affected version(s): `{version}-x-y` (i.e. `20-x-y`)
* Reviewed by another maintainer: `status/reviewed`, `status/confirmed`
* Affected platforms: `platform/all`, `platform/win`, `platform/mac`, `platform/linux`
* Urgency: `regression`, `crash`

**What version labels should I add if the issue originates well past supported versions?**

If you know the version of Electron where the issue began, add that version label. If you don't know when the issue began, but it is still affecting the latest version, add all of the current supported version labels.
