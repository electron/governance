# Electron Governance Charter

<!--
TODO:
- would be cool to get some icons / art for these values for use on the website (Sam)
  - +1 (Charles)
-->

## Core Values

These are our core values, as voted by the maintainers, in order of importance. When in doubt, these should guide our decisions.

1. **Deliberate Inclusivity**

   We take the time to include all good-faith contributors.
   The project works around the lives of real people, and people shouldn’t sacrifice a reasonable livelihood to participate.

2. **Intellectual Safety**

   We work to cultivate and maintain an environment where participants feel comfortable sharing ideas and opinions without fear of harsh judgments or repercussions. We practice blameless analyses of our missteps.

3. **Transparency**

   We make our governance public whenever reasonable. By doing this, we are able to create a shared and sharable understanding of what we're trying to do.

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
 * A _chair_ is the acting leader of a working group that uses the [Rotating Chair Model](rotating-chair-model.md).
 * A [_delegate_](#Delegation) is a chosen representative of a working group.

## Participation

 * [Code of Conduct](../CODE_OF_CONDUCT.md)
 * [Using Slack](../policy/slack.md)
 * [Triaging Issues](../playbooks/README.md)
 * [Using Pull Requests](../policy/pull-requests.md)

## Working Groups

| Working Group  | Repo | Description | 
|:---------------|:------|-------------|
| Administrative | [wg-administrative](../wg-administrative) | Administrates Governance |
| Community      | [wg-community-safety](../wg-community-safety/) | Handles Code of Conduct issues |
| Ecosystem      | [wg-ecosystem](../wg-ecosystem/) | Makes Electron app development easier |
| Outreach       | [wg-outreach](../wg-outreach/)   | Grows the community |
| Releases       | [wg-releases](../wg-releases/)   | Coordinates new releases |
| Security       | [wg-security](../wg-security/)   | Security review & response |
| Upgrades       | [wg-upgrades](../wg-upgrades/) | Ongoing Node & Chromium upgrades |
| API            | [wg-api](../wg-api/) | API design |

### Responsibilities

All Working Groups have these core responsibilities:
 * They shall decide for themselves, and publicly post, their rules, e.g. how decisions are made, when meetings are held, and who may attend.
 * They shall choose a model of work to support reaching the working group's goals.
 * They shall keep meeting notes, including agenda items, discussion points, and outcomes for everyone to review.
 * They shall be collaborative and work [in good faith](#Core-Values) with other Working Groups.

### Meetings

Group members live and work in many time zones, so synchronous meetings aren't always possible. No one should feel like they need to attend a meeting at an inconvenient time for their voice to be heard. If a group is to make a decision by voting, it shall make a reasonable effort to inform all members about the vote and give them a chance to vote outside of the meeting itself.

Members should have the opportunity to read a summary of the meeting and share pertinent opinions before voting is finalized. Groups may use [Doodle](https://doodle.com) or a similar mechanism to decide on meeting times that are convenient for the members.

### Delegation

Delegates have responsibilities to their Working Group: they represent the collective will of that group to others.

Delegates are [chosen](#Reaching-Agreement) by the members of their Working Group.

### Reaching Agreement

If an issue affects only one Working Group, that group can make decisions [on its own](#Meetings).

If an issue affects more than one Working Group, those groups are encouraged to work towards agreement together.

If agreement cannot be reached, delegates from all Working Groups shall try to decide the matter with a vote. A reasonable effort shall be made to let all interested working groups participate in this, but any working group may decide abstain.

If agreement still cannot be reached, the issue may be brought to the Administrative Working Group, which has final say.

Regardless of how agreement is reached, the participating groups shall make a reasonable effort to record and post their decisions for transparency.

# Electorate

The **Electorate** is the body who holds the ability to alter the charter and appoint members of the administrative working group.

Designing a new Electorate is currently out-of-scope for this charter.
Instead we make the implicit status-quo explicit.
GitHub will act as the Electorate with the intention of overseeing a replacement after the current governance is rolled out.

We want an Electorate which can balance several factors:

1. new contributors
2. long-time contributors
3. corporate sponsorship
4. financial contributions
5. tenured contributions

There is no explicit timeline around this,
but this charter expects it to be addressed in a reasonable timeframe.

## Administrative Working Group

See the [Working Group README](../wg-administrative)

The Administrative Working Group (AWG) is chartered with the responsibility to ensure governance is serving the best needs of the project and community.
The AWG has authority to act on the project, granted by the electorate.
The AWG in turn delegates its authority to all other working groups.

To prevent the AWG from becoming the sole political power of the project,
it is expected that the AWG abstains from casting individual technical decisions that are the responsibility of other working groups.
The AWG should principally serve as a _circuit breaker_.
If a delegate working group is failing to meet its responsibilities, the AWG may intervene up to and including altering group members, or altering the groups authority, responsibilities, or existence.

> **Authors note:**
> The current Electorate/AWG mix places almost all the power in the hands of a few large corporations at the outset. While not ideal to many, this was chosen because it represents the present status-quo, as of writing. The choice to delay defining an Electorate was made to _ensure_ it was not rushed, and that we have time to balance project stakeholders large and small.
