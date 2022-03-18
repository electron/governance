# Issue Triaging

Below is a basic guide for how the Electron team approaches triaging issues in Electron

## Evaluating Issues

We ask reporters to fill out an issue template when filing a new bug report. When reading a new issue, there are a few fields that can be quickly scanned to determine how to proceed:

* Electron Version: Is the version of Electron used in the report one of our supported versions (i.e. latest four versions)?
* Repro Gist: Does the issue have a repro gist or a comment with repro code for the issue?
* Expected/Actual Behavior: Is the user clear on what behavior should be happening, vs. what's actually happening?

Based on the information provided in the issue, we then add labels as needed and reply to the issue reporter. Below are some of the most common scenarios we encounter when triaging issues, with the tree of labels and responses below each one:

## Common Responses

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
