# Issue Triage

> Triage (/ˈtriːɑːʒ/ or /triːˈɑːʒ/) is the process of determining the priority of patients' treatments based on the severity of their condition. This rations patient treatment efficiently when resources are insufficient for all to be treated immediately.
>
> *From Wikipedia*

The above describes medical triage but it is clear that it also applies to our situation. Triage is a process of sifting through all the things that we could work on to select the few things that we will work on. In order to maximize the impact we have for the people that use Atom, things that will get top priority are items that are well-described, clearly presented and have obvious benefit.

Additionally, we want to encourage helpful feedback and meaningful participation. In order to do this, we will have to be clear about what we need from people so that we can deliver what they need. This also means that we will have to be very clear and decisive when we are not getting the information or cooperation we need so that we can move on. Just like in an emergency room, if it is a choice between spending several hours to have a 10% chance of saving one person or spending several hours definitely saving multiple people, the choice is clear.

## Goals

* Communicate clearly and effectively
  * What the maintainers will work on
  * What pull requests will be reviewed for acceptance
  * What pull requests *will not* be reviewed for acceptance
* Outline exactly what is expected for an issue to meet the "triage bar" so that issues that don't meet the bar can be closed
* Reduce the amount of time and back-and-forth needed to take an issue from being first-opened to `triaged` or closed
* Accept input from the community that helps us deliver meaningful results back to the Atom community

## The Issues List Is Our Backlog

The project issues list is what the maintainers team uses to guide our work. In order for our work to be focused and efficient, our issues list must be clean and well-organized. Accepting input from the community is a significant benefit *when it does not distract us from making things better*.

* Untriaged issues are tasks that are being evaluated to determine if they meet the triage bar
* Open triaged issues are tasks that the maintainers have agreed to work on
* Closed issues are things that either didn't meet the triage bar or are tasks that the maintainers will not be taking on

## The Triage Bar

In order to be considered `triaged` an issue **must** contain or be edited to contain in the body of the issue:

* **One** and only one issue
* Specific steps to reproduce the problem or desired behavior (see [Writing Good Bug Reports](http://www.lee-dohm.com/2015/01/04/writing-good-bug-reports/) for an explanation)
* If the steps to reproduce the problem do not reproduce it 100% of the time, an estimate of how often it reproduces with the given steps and configuration
* Any other information that is required to reproduce the problem (program version output, OS platform and version, sample Git repository, specific OS configuration, etc)

Additionally, to be given the `triaged` label:

* A maintainer must be able to reproduce the issue

### The Body of the Issue

You'll notice above that the body of the issue gets special mention. The body of the issue is the description of the task to be done. A maintainer should only have to read the body of the issue to understand what needs to happen. They should not have to read the pages of comments to understand what they need to do in order to address the issue at hand.

## Process

Keep in mind that this is not the 100% complete maintainer's guide to issues. This is only a triage process. Once everything has been checked, the issue reproduced and appropriate labels have been applied, the triage process is done with the issue. There may be additional maintenance that needs to be done on issues from time to time that isn't and won't be covered here.

1. Person files a new issue
1. Maintainer checks to ensure they adequately filled out the template. If not, close with the [request to fill out the template](responses/needs-template.md).
1. If the issue has already been fixed, close with [the already fixed message](responses/already-fixed.md)
1. If the issue is a duplicate, label with `duplicate` and close with [the duplicate notification](responses/duplicate-notification.md)
1. If the issue is feedback for the maintainers, label with `feedback`, and close with [the feedback message](responses/feedback.md)
1. If the issue is a question, label with `question` and close with [the deluge message](responses/deluge.md)
1. If the issue is reported on an obsolete version of Electron, label with `blocked/need-info` and respond with the [obsolete-version response](responses/obsolete-version.md)
1. If anything is unclear but the template is adequately filled out, post what questions you have and label with `blocked/need-info`
1. If the issue would be time-consuming because it lacks a test -- e.g., the issue is ambiguous, or a new test is needed for the steps required to trigger the bug, or the reporter invites you to triage their production application, respond with [blocked-needs-repro response](responses/blocked-needs-repro.md) and add the `blocked/needs-repro` label.
1. Maintainer attempts to reproduce the problem
    1. If the problem is not reproducible, label with `needs-reproduction` and ask the author of the issue for [clarification on the repro steps](responses/repro-steps.md)
    1. If the problem is reproducible, label with `triaged`

For issues that have been labeled `triaged`:

1. If it is reasonable to believe that an issue reproduces only on some subset of supported platforms, label with the appropriate `windows`, `linux` or `mac` labels

## More Information Needed

Periodically we should be doing a sweep of issues that are open and labeled `blocked/need-info` or `blocked/needs-repro`. If the original poster has not responded within two weeks after the last question by an official maintainer, close the issue with [the no response message](responses/no-response.md).

## Needs Reproduction

If a problem is consistently not reproducible, we **need** more information from the person reporting the problem. If it isn't a simple misunderstanding about the steps to reproduce the problem, then we should label it `blocked/need-info` as well and follow that process.

## What Happens After Triage?

Once an issue is triaged, the maintainers can work on addressing it. {{Insert stakeholders and prioritization process here.}} The possible outcomes here are:

* The issue goes on the backlog
* The issue is closed with `help-wanted` and an explanation that this is not something the maintainers will be working on soon, but well-written Pull Requests would be accepted
* The issue is closed for some other reason

Just because something goes on the backlog doesn't mean that it will be addressed immediately. But the idea is that all issues that are open will be periodically reviewed and kept in the priority list. Since we will be reviewing _all_ open issues at fixed time intervals, we will need to keep this list manageable and realistic.

## Old, Untouched Issues

Despite everyone's best efforts, old issues will always exist. If you find one that hasn't been touched in a quite a while _and_ you are unable to recreate the behavior, update the issue with the [old, untouched issues response](responses/old-untouched.md)
