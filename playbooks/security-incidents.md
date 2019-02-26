# Security Incidents

Sometimes vulnerabilities are discovered in Electron or its dependendencies like Chromium and Node. This playbook is designed
to help our team coordinate to fix these issues smoothly.

## Incident Response

Somethings is happening! It's gonna be okay. Stay calm. Take a deep breath. 👃

**Before taking any action**, join the 
[#security](https://electronhq.slack.com/messages/C3ANJ97H6) channel in Slack 
to talk about first steps.

- [ ] [Create a tracking issue on the maintainers repo](https://github.com/electron/maintainers/issues/new)
- [ ] Reproduce the vulnerability, if possible.
- [ ] Determine which versions of Electron should be patched.
- [ ] Create pull request(s) with the patch(es).
- [ ] Verify that the patch is effective, if possible.
- [ ] Merge pull requests.
- [ ] Tell everyone in Slack not to touch the release branches until the releases are done.
- [ ] Create new releases.
- [ ] Give friends and family at GitHub, Slack, Microsoft, Atlassian, etc a chance to upgrade before disclosing anything to the public. (This may not scale, but it's a start.)
- [ ] Blog about the fix.
  - Specify affected versions of Electron.
  - Specify how users should upgrade.
  - Provide technical details about the exploit. Since we're working in full transparency and anyone can look at PR and code changes, providing clear technical details helps defenders to prioritize work and (potentially) mitigate vulnerabilities in different ways. Technical details should **not include a reproduction sample**. Describe the issue in detail and outline possible exploit vectors, but do not point people at or provide resources that can help people create their own exploit.
  - Give credit for the discovery. Security researchers do appreciate credit and it's more likely that someone will keep looking for (and responsibly disclosing) bugs if you recognize their work.

  
  - Mention the proper channel for disclosing vulnerabilities: Email electron@github.com with `SECURITY` in the subject line.
- [ ] Email our [Google Group](https://groups.google.com/forum/#!forum/electronjs) to notify folks about to update.
- [ ] Tweet a link to the blog post.

## Retrospective

After the dust has settled (but not too long after), take some time to have a 
team retrospective. Here are some guidelines:

- [ ] Put it on the calendar and invite all maintainers.
- [ ] Incident responders should join if possible.
- [ ] Host the meeting on Zoom or Slack.
- [ ] Designate a notetaker.
- [ ] What worked well?
- [ ] Can we prevent this from happening again?
- [ ] What could we do better next time?
- [ ] Refine the playbook based on findings.
