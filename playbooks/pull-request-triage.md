# Pull Request Triage

> Triage (/ˈtriːɑːʒ/ or /triːˈɑːʒ/) is the process of determining the priority of patients' treatments based on the severity of their condition. This rations patient treatment efficiently when resources are insufficient for all to be treated immediately.
>
> *From Wikipedia*

The above describes medical triage but it is clear that it also applies to our situation. Triage is a process of sifting through all the things that we could work on to select the few things that we will work on. In order to maximize the impact we have for the people that use Electron, things that will get top priority are items that are well-described, clearly presented and have obvious benefit.

Additionally, we want to encourage helpful feedback and meaningful participation. In order to do this, we will have to be clear about what we need from people so that we can deliver what they need. This also means that we will have to be very clear and decisive when we are not getting the information or cooperation we need so that we can move on. Just like in an emergency room, if it is a choice between spending several hours to have a 10% chance of saving one person or spending several hours definitely saving multiple people, the choice is clear.

## Goals

* Help the development team review PRs faster by encouraging potential contributors to give us the information we need to make an informed decision
* Encourage higher-quality PRs

## The Pull Request Bar

For a Pull Request to be marked `triaged` it **must** contain or be edited to contain in the body of the PR:

* A detailed description of the change - we shouldn't have to look at the code to understand how the code is designed
* What alternates were considered and why this design was chosen
* If the PR does not apply to all platforms, why is this a valid approach
* The expected benefits of the change
* Possible drawbacks of the change
* Mentions of any Issues that this applies to or is fixing

Additionally, to be given the `triaged` label:

* The PR must contain tests for any new functionality or update old tests for changes in functionality

## Process

Keep in mind that this is not the 100% complete maintainer's guide to pull requests. This is only a triage process. Once everything has been checked, the design reviewed and appropriate labels have been applied, the triage process is done with the pull request. There may be additional maintenance that needs to be done on pull requests from time to time that isn't and won't be covered here.

1. Person files a new pull request
1. Maintainer checks to ensure they adequately filled out the template. If not, close with the [request to fill out the template](responses/needs-template.md).
1. If the pull request does not include tests, label with `needs-testing` and close with the [needs testing message](responses/needs-testing.md)
1. If the pull request is a work-in-progress, label with `work-in-progress` and post the [work-in-progress message](responses/work-in-progress.md)
1. If anything is unclear but the template is adequately filled out, post what questions you have and label with `more-information-needed`
1. Maintainer checks to see if the automated tests passed
    1. If the tests did not pass (for reasons that the author had under their control), label with `requires-changes` and ask the author to [fix the broken tests](responses/fix-tests.md)
    1. If the tests did pass, label with `triaged`

## Work In Progress

Pull requests that are works in progress should be the exception rather than the rule. If the pull request doesn't see any updates to the body or its content within two weeks of the time we look at it, close the pull request with [the stale pull request message](responses/work-in-progress.md).

## More Information Needed

Periodically we should be doing a sweep of pull requests that are open and labeled `more-information-needed`. If the original poster has not responded within two weeks after the last question by an official maintainer, close the pull request with [the no response message](responses/no-response.md).

## What Happens After Triage?

Once a PR is triaged, the maintainers can work on addressing it. {{Insert stakeholders and prioritization process here.}} The possible outcomes here are:

* The pull request goes into the queue to be reviewed
* The pull request is closed with an explanation of why this isn't a valid approach to the problem
* The pull request is closed with an explanation of why this isn't something we want to accept
* The pull request is closed for some other reason

Just because something is in the queue to be reviewed doesn't mean that it will be addressed immediately. We expect all pull requests to be reviewed within TBD weeks.
