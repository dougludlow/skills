# Compact project record

Use one record, scaled to the effort. Omit fields that add no value. Its current overview should let the user understand the project's position without reconstructing worker activity. Refresh that overview and the resume state from reconciled evidence after material changes, replacing superseded status. Keep dated history and detailed verification below the current sections or in linked artifacts, with their original scope, version, and observation time. The same separation applies when an existing record uses JSON or another structured format; read the relevant current fields rather than the whole history. Avoid a second ticket system or transcript archive.

```markdown
# <Project or experiment>

## Current overview
Goal and why:
Overall status against acceptance criteria:
Current milestone and completed outcomes:
Latest verified result, evidence, and project impact:
Remaining outcomes and dependency blocking the next milestone:
Next action and owner:
Next review / decision for the user (or none needed):
Last reconciled:

## Resume state
User's preferred name / source (when available):
Acceptance criteria:
Scope / excluded work:
Experiment question, baseline, stopping condition (if applicable):
Applicable constraints and permissions / sources in the user's instructions:
Orchestrator chat / worker title prefix:
Tracker and repository links (optional):
Pilot or representative prior unit (when needed):
Active operation IDs:
Worker type and native report delivery / wait cursors:
Visible-chat messaging authorization: source in the user's instructions, covered chat IDs, direction, scope / conditions (if applicable):
Environment preflight: relevant inputs, result / failure category, blocked action and resume condition:
Artifact destination / producer write access / handling constraints (only when needed):
Continuation mechanism / identity / verified wakeup behavior / cadence / next check:
Notification preference / terminal and cleanup condition:
Next reconciliation action / trigger:

### Active work
| Work unit / current assignment | Owner chat ID / host or subagent | Scope / dependency | Worktree / branch / verified checkout | State / exact artifact version / accepted result / processed report / wait cursor |
| --- | --- | --- | --- | --- |

### Monitoring
| Live check / artifact version | Monitoring owner | Report delivery / latest observation | Backstop / stale-after condition | Stop condition |
| --- | --- | --- | --- | --- |

## Milestones
| Milestone | Outcome and acceptance evidence | Review point | State |
| --- | --- | --- | --- |

## Verification receipts
| Work unit / assignment | Acceptance check | Artifact version / input snapshot | Method / environment | Outcome / evidence / limits |
| --- | --- | --- | --- | --- |

## Decisions and permissions
| Decision or allowed action | Scope / conditions | the user's instruction or project decision evidence |
| --- | --- | --- |

## Follow-up and cleanup
Chats needing follow-up or authorized archival:
Open limitations / deferred work:
```

## Resume state

Keep the current overview and resume state small enough to read as bounded sections. The resume state carries the effective acceptance criteria, constraints and permissions with their sources, active assignments and versions, report cursors, monitoring ownership, and next action. Keep active facts here once; link detailed briefs and receipts, and move finished assignments to dated history. If a required constraint or approval is missing or ambiguous, read its authoritative source before acting.

Read history and full receipts for changed evidence, conflicts, missing context, or an acceptance decision that needs them. Resume state identifies what to inspect; it does not turn a worker summary into verified acceptance. Preserve timestamps on mutable observations and honor any requirement for fresh readback.

Distinguish ready, active, blocked, awaiting review, accepted, and complete when useful. Evidence links should explain the state; avoid a rigid lifecycle that does not fit the effort.

Keep receipt detail proportional to the check; a short work-row entry can replace the separate table. Use identities such as a PR head SHA, document revision/checksum, or data snapshot. An operation ID identifies a run; claims about mutable data also need readback scope and observation time. Link the underlying evidence instead of copying logs. A green result for an earlier version remains evidence for that version; assess which criteria need fresh checks after changes and record any justified reuse.

When retries or changed briefs make assignments ambiguous, use a simple attempt or scope revision such as `W2/a2`, alongside the existing worker/run IDs. Preserve the prior assignment's disposition and useful artifacts. Deduplicate using a report ID or its pointer/content, not artifact version alone: a later report about the same version may contain new evidence. Record that evidence without treating a repeated success as another completion or repeating its downstream effects.

## Worker brief and report

Lead with the implementation plan for this assignment. Include only context that changes how the worker should implement or verify it. The orchestrator keeps assignment identities, project status, wait cursors, and monitoring administration in its own record. The worker needs the return destination and applicable boundaries, not the orchestration procedure. Omit inapplicable fields.

```text
Implement this plan for <user name>. Refer to them by name.
<Assignment-specific plan, including scope, expected behavior, and required checks.>

Context: <Relevant code, prerequisite results, and applicable constraints.>
Worktree: <Absolute root and branch; verify before repository work.>
Review: Ask one or two subagents to critique the plan, then the implementation.
Give each a separate verified worktree and the current version or patch.
Address justified findings.
Done: <Acceptance criteria and authorized delivery stage, including any review boundary.>
Report: Send a brief update to <authorized orchestrator chat ID / native parent>
at the end of every turn. Check in sooner for blockers, required decisions,
consequential scope or dependency changes, or a result that unblocks others.
Continue routine work without waiting for acknowledgment.
```

Keep each report to a few sentences, with links for evidence:

```text
Result: <What changed, with a commit, PR, artifact version, or precise diff reference.>
Checks: <Verification and review outcomes, evidence, and remaining limits.>
Next: <Next action, waiting condition, or exact blocker / decision needed.>
```

For supporting lookups or reviews, send just the bounded question, relevant sources, workspace if needed, and return route. Keep reports within the assignment's scope; the orchestrator assesses project impact and acceptance. See [worker reporting rules](codex-orchestration.md#worker-reports) for check-in timing and delivery.

## Orchestrator updates

Use the current overview to explain the project, selecting the details relevant to this update rather than reciting every field. For a hypothetical feature with API and interface work, an illustrative milestone update could read:

> The API changes pass their required checks, but the feature still needs interface integration before it is ready for your review. The combined user flow remains unverified.
>
> The interface worker is connecting the new behavior and will check the complete flow next. No decision is needed from you yet; the next review will assess whether the feature meets the agreed acceptance criteria.

Before sending a progress report or saving the overview, check that a reader can identify the goal, overall status, result's significance, remaining dependency, and next action or decision within about 30 seconds. Keep the explanation understandable without decoding assignment IDs or opening receipts. Retain the supporting metadata and evidence links for inspection. Check each claim against reconciled evidence and label unknowns.

When assessing orchestration efficiency, compare usage per accepted milestone when available, alongside wakeups, repeated reads, rework, completion time, and clarification requests to the user. Preserve the same acceptance criteria and required checks. Fewer calls alone establish neither a cost saving nor unchanged quality; label unavailable usage data rather than estimating savings from message length.
