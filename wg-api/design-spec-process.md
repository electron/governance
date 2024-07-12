> [!CAUTION]
> This process was deprecated in favor of the public RFC process. See [electron/rfcs](https://github.com/electron/rfcs) for more information.

# API Spec Process

## What Is This Used For?

The API Working Group should function as a clear escalation path towards resolving differing perspectives for the following API changes:

* A new API
* An API removal with replacement
* An API deprecation and removal with no replacement
* A change in the semantics of an existing API.

This process is only intended to be used when there is disagreement amongst maintainers or there are strong objections to a change.

## What Is The Process?

For API changes falling under the categories above and for which no consensus can be reached, a spec document should be written.

This document has no minimum length and can thus be short, but should cover all basic information outlined in the [`api-spec-template`](spec-documents/api-spec-template.md).

This document will be able to provide rationale for the choice as well as preserve considerations and allow the WG to more easily ratify a specific approach.

## Ratifying Spec Change Proposals

Once this document has been written, it should be placed on the API Working Group's agenda for a given meeting, where the group will discuss and vote with sufficient consensus to move forward with one of the proposed solutions in a given design document.

Once a proposal has been ratified, it will be PRed into the [`spec-documents`](spec-documents/) directory to allow external community members to better understand the process behind the technical decision that was made.
