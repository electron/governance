# Electron Governance Charter

## Core Values
<!-- Side note, would be cool to get some icons / art for these values for use on the website (Sam) -->
<!-- :+1: (Charles) -->

These are our core values, as voted by the maintainers, in order of importance. When in doubt, these should guide our decisions.

1. **Deliberate Inclusivity**
   We take the time to include all good-faith contributors.
   The project works around the lives of real people, and people shouldn’t sacrifice a reasonable livelihood to participate.
2. **Intellectual Safety**
   We work to cultivate and maintain an environment where participants feel comfortable sharing ideas and opinions without fear of harsh judgments or repercussions. We practice blameless analyses of our missteps.
3. **Transparency**
   Be transparent in as wide of a group as is reasonable.
4. **Accountability**
   People need a channel for safely communicating feedback to other maintainers.
5. **Shipping**
   We constantly strive to improve through iteration. Some ships will sink, so we build processes to accommodate expected failures as a safety net.
6. **Sharing**
   We seek to share knowledge of the project between maintainers. We share responsibilities and seek to meet objectives as a team.

## Definitions

 * A _maintainer_ is anyone who plays an active role in governance.
 * A _collaborator_ is active in the community, but not in governance.
 * A _participant_ is anyone who is a maintainer or collaborator.
 * A _working group_ is a group of maintainers that is formed to take responsibility for certain aspects of the Electron project. Normally these groups will meet regularly but in some cases will only meet as required to fulfill their responsibilities.
 * A [_chair_](#Leadership) leads a working group.

## Participation

 * [Code of Conduct](https://github.com/electron/governance/blob/CODE_OF_CONDUCT.md)
 * [Using Slack](https://github.com/electron/governance/blob/master/Slack.md)
 * [Triaging Issues](https://github.com/electron/governance/blob/master/playbooks/README.md)
<!-- * [Using Pull Requests](FIXME: link to PR etiquette doc) -->

## Working Groups

| Working Group  | Links | Description | 
|:---------------|:------|-------------|
| Community      | [Slack](https://electronhq.slack.com/messages/CGFP1R38Q), [Repo](/wg-community-safety) | Handles Code of Conduct issues |
| Docs and Tools | [Slack](https://electronhq.slack.com/messages/CG8ME4622), [Repo](/wg-docs-tools) | Docs, tools, and Userland |
| Outreach       | [Slack](https://electronhq.slack.com/messages/CBCRYJA79), [Repo](/wg-outreach) | Grows the community |
| Releases       | [Slack](https://electronhq.slack.com/messages/CC80G2R6H), [Repo](/wg-releases) | Coordinates new releases |
| Security       | [Slack](https://electronhq.slack.com/messages/C3ANJ97H6), [Repo](/wg-security) | Security review & response |
| Upgrades       | [Slack](https://electronhq.slack.com/messages/C5VT8SQ8K), [Repo](/wg-upgrades) | Ongoing Node & Chromium upgrades |
| Website        | [Slack](https://electronhq.slack.com/messages/C43E13N0J), [Repo](/wg-website) | Maintains [electronjs.org](https://www.electronjs.org) |

### Responsibilities

All Working Groups have these core responsibilities:
 * They shall decide for themselves, and publicly post, their rules, e.g. how decisions are made, when meetings are held, and who may attend.
 * They shall [select](#Leadership-Terms-and-Selection) a chair to [represent](#Leadership-Responsiblities) the group.
 * They shall keep meeting notes, including agenda items, discussion points, and outcomes for everyone to review.
 * They shall be collaborative and work [in good faith](#Core-Values) with other Working Groups.

### Meetings

Group members live and work in many time zones, so synchronous meetings aren't always possible. No one should feel like they need to attend a meeting at an inconvenient time for their voice to be heard. If a group is to make a decision by voting, it shall make a reasonable effort to inform all members about the vote and give them a chance to vote outside of the meeting itself.

Members should have the opportunity to read a summary of the meeting and share pertinent opinions before voting is finalized. Groups may use [Doodle](https://doodle.com) or a similar mechanism to decide on meeting times that are convenient for the members.

### Leadership

#### Leadership Terms and Selection

Each Working Group shall be led by a Chair.

The Chair shall have a four month term. A person is eligible to chair the Working Group if and only if they satisfy all conditions:
  1. They wish to serve as Chair.
  1. They are a member of the Working Group.
  1. They are not the chair of more than one other Working Group. (i.e. One person may chair a maximum of two Working Groups at a time)
  1. They have not Chaired that Working Group more recently than any eligible member. (Think of “shuffle play” music)

A Working Group can not have the same chair twice in a row. If the only person willing to serve next is the current chair, this is a sign of an unhealthy group and should be addressed by the Administrative Working Group.

The group will make a reasonable effort to notify potential candidates that a new term is coming so that interested parties can declare their eligibility.

A chair is selected at random from the set of eligible candidates. The candidates and selection are to be documented and made public.

A chair's term does not need to begin at the same time as other chairs' terms.

If a chair steps down, a new one is selected and a new four-month term begins (i.e., interim Chairs are not needed)

#### Leadership Responsibilities

Chairs have responsibilities to their Working Group: they represent the collective will of that group to others.

Chairs have responsibilities to their parent Working Group: they ensure that their Working Group is carrying out its mission.

Chairs have responsibility to all participants in transparently reporting the group's activity.

### Reaching Agreement

If an issue affects only one Working Group, that group can make decisions [on its own](#Meetings).

If an issue affects more than one Working Group, those groups are encouraged to work towards agreement together.

If agreement cannot be reached, the chairs of all Working Groups shall try to decide the matter with a vote. A reasonable effort shall be made to let all interested chairs participate in this, but any chair may abstain.

If agreement still cannot be reached, the issue may be brought to the Administrative Working Group, which has final say.

Regardless of how agreement is reached, the participating groups shall make a reasonable effort to record and post their decisions for transparency.

