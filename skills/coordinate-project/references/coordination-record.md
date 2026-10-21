# Compact project record

Use one record, scaled to the effort. Omit fields that add no value. Its current overview should let the human understand the project's position without reconstructing worker activity. Refresh that overview and the resume state from reconciled evidence after material changes, replacing superseded status. Keep dated history and detailed verification below the current sections or in linked artifacts, with their original scope, version, and observation time. The same separation applies when an existing record uses JSON or another structured format; read the relevant current fields rather than the whole history. Avoid a second ticket system or transcript archive.

```markdown
# <Project or experiment>

## Current overview
Goal and why:
Overall status against acceptance criteria:
Current milestone and completed outcomes:
Latest verified result, evidence, and project impact:
Remaining outcomes and dependency blocking the next milestone:
Next action and owner:
Next human review / decision (or none needed):
Last reconciled:

## Resume state
Acceptance criteria:
Scope / excluded work:
Experiment question, baseline, stopping condition (if applicable):
Applicable constraints and permissions / human sources:
Coordinator chat / worker title prefix:
Tracker and repository links (optional):
Pilot or representative prior unit (when needed):
Active operation IDs:
Worker type and native report delivery / wait cursors:
Visible-chat messaging authorization: human source, covered chat IDs, direction, scope / conditions (if applicable):
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
| Decision or allowed action | Scope / conditions | Human source or project decision evidence |
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

Scale the brief to the assignment. State how the outcome contributes to the parent project so the worker can identify relevant dependencies and risks.

```text
Project goal and current milestone:
How your outcome contributes to the project:
Work-unit identity and current assignment / attempt:
Your outcome and acceptance criteria:
Scope and dependencies; what is already verified:
Relevant code, standards, context, source artifacts:
Assigned worktree absolute path / branch:
Artifact destination and confirmed producer write access (only when needed):
Worker type / native delivery route; applicable visible-chat messaging authorization:
Checkout verification and workspace constraints for any child agents:
Decisions and permissions applicable to this assignment:
Authorized completion stage / coordinator checkpoints / human review or stop conditions:
Handoff: use the report below at a meaningful milestone, completion, blocker,
or decision. State what remains unverified.
```

Worker report (keep it concise):

```text
Outcome and project impact:
Changed files / commit or PR / exact artifact version (when applicable):
Verification and limits, with evidence links:
Blockers or unresolved dependencies (or none):
Artifact paths (only when produced):
Next action or decision (only when needed):
Metadata: work unit / assignment; verification environment or input snapshot.
```

Use sentences for the explanation and labeled values for metadata. Report implications within the assignment's scope; bring proposed scope changes to the coordinator. Evidence of a completed assignment supports the parent's acceptance review; the coordinator assesses its effect on overall project completion.

## Coordinator updates

Use the current overview to explain the project, selecting the details relevant to this update rather than reciting every field. For example, during a test-framework migration, an illustrative milestone update could read:

> The integrations pilot has demonstrated a useful improvement, but broader Jest migration remains pending. Fixing a shared test fixture reduced the affected file's warm test time from roughly 26–28 seconds to 5.5–5.7 seconds, while preserving the selected 222 tests and coverage. These measurements apply to the selected tests; the effect on the full suite remains unmeasured.
>
> CI, review, and a small testing-policy correction remain before the pilot comes back for your review. The implementation worker is handling the correction and remaining checks. No decision is needed from you yet; the next review will assess whether this pilot is ready and what should migrate next.

Before sending a progress report or saving the overview, check that a reader can identify the goal, overall status, result's significance, remaining dependency, and next action or decision within about 30 seconds. Keep the explanation understandable without decoding assignment IDs or opening receipts. Retain the supporting metadata and evidence links for inspection. Check each claim against reconciled evidence; label unknowns and keep the example's measurements out of unrelated project reports.

When assessing orchestration efficiency, compare usage per accepted milestone when available, alongside wakeups, repeated reads, rework, completion time, and human clarification requests. Preserve the same acceptance criteria and required checks. Fewer calls alone establish neither a cost saving nor unchanged quality; label unavailable usage data rather than estimating savings from message length.
