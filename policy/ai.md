# AI Tool Policy

Electron welcomes contributions crafted with many different tools: IDEs, linters, Web community resources, and so on. LLMs—and AI tools built on them—are becoming more prevalent in contributors' toolkits. Like any tool, what matters is not *how* you wrote something, but whether **you understand it, can defend it, and take responsibility for it**.

These standards of quality, effort, and accountability have always applied to contributions; we're making them explicit now because AI tools make it trivially easy to generate superficially plausible content without understanding it.

Our core principle is simple: **there must be a human in the loop**.

Contributors **must** review, understand, and be able to explain all content they submit, regardless of how it was produced. If you use AI tools to help write code, documentation, comments, or any other contribution, **you are still the author and bear full responsibility for the work**.

This means:

* You have **read and reviewed** content before submitting it
* You can **answer questions** about your work during review
* You have **built and tested** code contributions

Submitting unreviewed AI-generated content wastes scarce maintainer time and is unacceptable behavior. Contributions that lack thoughtfulness and care may be declined outright.

## What's allowed

* Drafting code or documentation that you then review, understand, and edit in-depth
* AI-assisted language utilities: spelling & grammar checkers, translators
* Authorized bots and agents owned by the Electron project (e.g. trop, roller, CI integrations, merged agent workflows)

## What's not allowed

> [!NOTE]
> *The list below is illustrative, not exhaustive. Read the rest of this policy.*

* Submitting AI-generated content you haven't reviewed or don't understand
* Posting AI-generated comments directly to issues or PRs without meaningful human input
* Unauthorized, automated agents that take action without human input (e.g. bots that post comments or open PRs autonomously)
* Automated agents that post subjective commentary or code review feedback without human review
* Passing maintainer feedback to an LLM and posting the response as your own reply

## Handling violations

Violations of this policy will be handled according to our [Code of Conduct](https://github.com/electron/electron/blob/main/CODE_OF_CONDUCT.md) [enforcement guidelines](https://github.com/electron/electron/blob/main/CODE_OF_CONDUCT.md#enforcement-guidelines). In short: we use a mix of private correction notes, public warnings, and temporary/permanent bans to enforce this policy.

Maintainers may close pull requests, close issues, and hide comments that appear to violate this policy without further review, citing a link to this policy. Contributors are welcome to ask clarifying questions, revise, and resubmit once they can demonstrate understanding of their contribution.

## Scope

This policy applies to, but is not limited to, the following kind of contributions:

* Code (pull requests; PRs)
* Issues, bug reports
* Comments, discussions
* Code reviews, feedback
* Documentation
* RFCs, proposals

The Electron project as a whole is covered by this policy, including (but not limited to) the main `electron/electron` repository as well as other project repositories: `electron/forge`, `electron/website`, etc.

## Conventions

### Disclosure in code contributions

We encourage disclosure of AI tool assistance in code contributions. This practice helps facilitate productive code reviews, and is not used to police tool usage.

When AI tools meaningfully assist in your contribution, note it in the commit message with a [trailer](https://git-scm.com/docs/git-interpret-trailers):

```plaintext
Assisted-By: Claude Opus 4.5, Claude Code

#  also acceptable:

Co-Authored-By: Claude <noreply@anthropic.com>
Generated-By: GitHub Copilot
```

Include the models used and any additional wrappers around them. At minimum, the "brand" of model or user-facing tool used is required when writing a trailer.

Disclosure is mandatory when AI-generated code is accepted largely as-written. That is, you reviewed it and found it acceptable without significant restructuring or rewriting. We recommend the `Co-Authored-By:` trailer in these situations because it is featured more prominently on GitHub and other tools.

Trailer conventions may evolve as the broader open-source community converges on standards; we'll update this guidance accordingly.

### Philosophy for contributors

We encourage contributors to treat AI tools as a **quality multiplier**, not just a speed multiplier. Reinvest time savings in:

* Tackling the tedious work that often gets skipped
* Writing better tests, covering more edge cases
* Refactoring for clarity

### Guidance for new contributors

We aspire to be a welcoming community that helps new contributors grow. Our guidance: **start small**. Submit contributions you can fully understand, get feedback, and iterate.

As maintainers, we want *your* contributions, not the tools’ outputs. Learning involves taking small steps; passing maintainer feedback directly to an LLM doesn't help anyone grow, and doesn't sustain our community.
