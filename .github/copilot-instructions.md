<!-- Copilot / AI agent instructions for contributors to the governance repo -->
# Repository Intent (big picture)

This repository holds the Electron governance documentation: charters, playbooks, policies, working-group (WG) READMEs, meeting notes, and small helper scripts. Changes are made by PR and reviewed against the playbooks and charter.

# Where to look first

- **Charter & roles:** [/charter/README.md](/charter/README.md)
- **Playbooks (triage, PR expectations, canned responses):** [/playbooks/README.md](/playbooks/README.md) and files in [/playbooks/responses](/playbooks/responses)
- **Working groups:** top-level `wg-*` directories (each has `README.md`, `meeting-notes/`, and often `repos.md`). Example: [/wg-api/meeting-notes/2019-09-26.md](/wg-api/meeting-notes/2019-09-26.md)
- **Scripts:** small utilities are in WG folders (e.g. [/wg-upgrades/rotation_generator.js](/wg-upgrades/rotation_generator.js) and `/wg-infra/scripts/`)

# What agents should know (concrete, actionable)

- This is a documentation/governance repo — there is no build/test pipeline to run here. Most changes are plain Markdown edits and small Node scripts.
- Meeting notes follow a pattern:
  - Files in `wg-*/meeting-notes/` named like `YYYY-MM-DD.md`.
  - Heading uses `# Date: YYYY-MM-DD` and lists attendees with GitHub handles (see [/wg-api/meeting-notes/2019-09-26.md](/wg-api/meeting-notes/2019-09-26.md)).
  - Use checkboxes for action items and keep an `Agenda` and `Followup` sections.
- PR triage & PR content expectations are enforced by the playbooks: ensure PR bodies follow the Pull Request Bar in [/playbooks/pull-request-triage.md](/playbooks/pull-request-triage.md) (detailed design, alternatives, cross-platform notes, tests, linked issues).
- Use canned response templates from [/playbooks/responses](/playbooks/responses) when closing issues/PRs or requesting changes — reference the exact file when posting the message.

# Conventions and patterns to follow

- New WG onboarding: add a top-level `wg-<name>/` directory with a `README.md`, `meeting-notes/` folder, and `repos.md` if applicable. See [/charter/rotating-chair-model.md](/charter/rotating-chair-model.md) for chair selection and responsibilities.
- Archive stale docs under `archived/` rather than deleting historical records.
- When adding scripts, keep them small and self-contained. Document how to run them in the WG directory README (examples use `node script.js`).

# Integration and external references

- The playbooks link to external repo templates (e.g. `electron/electron` issue templates). Agents should preserve those references and avoid duplicating them.
- This repo is largely cross-referential: many WG READMEs link into `charter/`, `policy/`, and `playbooks/`. Update links when moving files.

# Editing guidance for AI agents

- Keep edits minimal and focused: update the file(s) needed, add a short PR description, and reference playbook rules when changing processes.
- For any change that affects process (playbooks, policy, code-of-conduct), add a short summary of rationale in the PR body and tag reviewers from the relevant WG README.
- Prefer using existing templates and canned messages from `playbooks/responses` rather than inventing new text.

# Quick examples

- Add meeting notes: create `wg-<name>/meeting-notes/2026-01-13.md` with `# Date: 2026-01-13`, attendees list of `@handles`, `Agenda`, and action items as checkboxes.
- Update a playbook step: edit [/playbooks/pull-request-triage.md](/playbooks/pull-request-triage.md) and reference any updated canned responses in [/playbooks/responses/](/playbooks/responses/) in the PR description.

# Search tips for agents

- Look under `wg-*` directories for WG-specific policies and meeting notes.
- Grep for `triage`, `meeting-notes`, `responses/`, or `rotating-chair-model.md` to find typical patterns.

# Safety & scope

- Do not change the Code of Conduct (`CODE_OF_CONDUCT.md`) or legal/charter text without explicit human reviewer approval.
- If uncertain about a process change, open a PR marked `work-in-progress` and request guidance from the relevant WG.

---
If any section above is unclear or you want more examples (e.g., more meeting-note templates or common canned replies), tell me which area to expand.
