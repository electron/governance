# Electron's GitHub Security Advisory Process

This document outlines the steps that members of the Electron Security Working Group should follow when receiving new reports via GitHub's Security Advisories. These steps ensure that security vulnerabilities are addressed efficiently and effectively.

## Initial Review

* **Assign a reviewer:** The WG member assigned to the incoming report should verify that the report is complete and accurate.
* **Check the Reporter's Details:** Ensure that the vulnerability reporter's information and affiliations are documented appropriately.
  * If details are missing, reach out to the reporter for clarification.

## 1. Assess the Vulnerability

A member of the Security WG should assess the vulnerability to determine its severity and what options exist to potentially address it.

Some possible options include:

* Backporting a CL from Chromium to address a vulnerability in Chromium code.
* Opening a new PR to Electron to fix a vulnerability in our source code.

The assigned WG member then needs to determine the versions of Electron affected by the vulnerability.

As an example, if the vulnerability originates upstream in Chrome, the member should:

1. Find the CL that introduced the issue using [Chromium Review](https://chromium-review.googlesource.com/) and the reporter's information.
2. Determine what Chromium version the CL was released in using [ChromiumDash](https://chromiumdash.appspot.com/commits).
3. Determine what Electron version first contained the above Chromium version.

If the issue is unpatched, a given fix would need to go to all supported lines after that version. If the issue has been patched upstream, the fix CL would need to go to all supported versions of Electron that contain the vulnerability and *not* the fix.

Use npm's [semver website](https://semver.npmjs.com/) to validate the affected version range determined as a result of this process.

## 2. Fix the Vulnerability

Depending on the result of the assessment in the previous step, the WG member should work with other engineers to open PRs to Electron's `main` and release branches as necessary. The PR description should **not** indicate that it fixes a security vulnerability **nor** link to any information that would insinuate that.

Once the PRs to fix the vulnerability have been merged and released, note the first versions to contain the fix for each supported version.

## 3. Draft the Advisory

After assessing the vulnerability, we need to draft and fill out the advisory in order to publish it.

* **Summarize the Issue:** Provide a concise description of the vulnerability.
  * Some specifics (like attack vectors) may be too technical and should be generalized to avoid exploitation by malicious actors.
  * We should remove all explanation in the advisory description of how to exploit the vulnerability - some smart readers may be able to discern it anyway but that's ok.
* **Affected Versions:** Specify the Electron versions impacted by the vulnerability as determined in Step 1.
* **Patched Versions:** Specify the Electron versions that contain the appropriate fix as per Step 2.
* **Assess Severity:**
  * Follow the Common Vulnerability Scoring System (CVSS) to assign a severity score using the [NIST Calculator](https://nvd.nist.gov/vuln-metrics/cvss/v3-calculator).
    * Determining a score is often subjective, so it's useful for multiple WG members to score independently, compare scores and rationales, and come to a final score collaboratively.
    * [Example Advisory](https://github.com/electron/electron/security/advisories/GHSA-7m48-wc93-9g85) for an ASAR Integrity bypass with a score of 6.1/10.
* **Mitigation Steps:** Outline any temporary mitigations if the issue can't be fixed immediately.
  * If the issue cannot be mitigated except by updating to a patched version, that should be specified.
* **Acknowledge The Reporter:** If applicable, provide credit to the reporter in the final advisory (with their permission).

These steps can be done in parallel with Step 2 - the information needs to be updated after fixes are published if the WG members choose to proceed this way.

## 4. Update and Finalize the Advisory

After verifying the patch, update the security advisory draft to reflect any changes in the status of the fix or mitigation strategies.

We should also keep the original reporter informed of the status of their submission as necessary, and  collaborate with them if any clarifications or further information is needed.

At this point, a WG member should copy the GHSA body into the Electron Security Advisory channel, thereby notifying all prominent apps and giving them some lead time to ensure their applications are secured.

## 5. Publish the Advisory

Once the advisory is ready to publish, request a CVE from GitHub via the automated process.

The vulnerability should be published to the wider development world 30 days after patched versions of Electron have been released for all affected stable release lines.
