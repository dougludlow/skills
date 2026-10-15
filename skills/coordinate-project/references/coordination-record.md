# Compact project record

Use one record, scaled to the effort. Omit fields that add no value. Keep current state at the top and link detailed evidence; avoid a second ticket system or transcript archive.

```markdown
# <Project or experiment>

Goal and why:
Acceptance criteria:
Scope / excluded work:
Experiment question, baseline, stopping condition (if applicable):
Coordinator chat / project prefix:
Tracker and repository links (optional):

## Current state
Current milestone:
Latest verified result and evidence:
Pilot or representative prior unit (when needed):
Next action / dependency:
Next human review / decision:
Last reconciled:

## Milestones
| Milestone | Outcome and acceptance evidence | Review point | State |
| --- | --- | --- | --- |

## Work
| Work unit | Owner chat ID / host or subagent / current assignment | Scope / dependency | Worktree / branch / verified checkout | State / artifact version / accepted result / processed report |
| --- | --- | --- | --- | --- |

## Verification receipts
| Work unit / assignment | Acceptance check | Artifact version / input snapshot | Method / environment | Outcome / evidence / limits |
| --- | --- | --- | --- | --- |

## Decisions and permissions
| Decision or allowed action | Scope / conditions | Human source or project decision evidence |
| --- | --- | --- |

## Follow-up and cleanup
Worker report delivery / coordinator ID and callback authorization (if applicable):
Monitor ID, cadence, notification preference, stop condition (if requested):
Chats needing follow-up or authorized archival:
Open limitations / deferred work:
```

Distinguish ready, active, blocked, awaiting review, accepted, and complete when useful. Evidence links should explain the state; avoid a rigid lifecycle that does not fit the effort.

Keep receipt detail proportional to the check; a short work-row entry can replace the separate table. Use identities such as a PR head SHA, document revision/checksum, or data snapshot. An operation ID identifies a run; claims about mutable data also need readback scope and observation time. Link the underlying evidence instead of copying logs. A green result for an earlier version remains evidence for that version; assess which criteria need fresh checks after changes and record any justified reuse.

When retries or changed briefs make assignments ambiguous, use a simple attempt or scope revision such as `W2/a2`, alongside the existing worker/run IDs. Preserve the prior assignment's disposition and useful artifacts. Deduplicate using a report ID or its pointer/content, not artifact version alone: a later report about the same version may contain new evidence. Record that evidence without treating a repeated success as another completion or repeating its downstream effects.

Worker brief:

```text
Project goal and current milestone:
Work-unit identity and current assignment / attempt:
Your outcome and acceptance criteria:
Scope and dependencies; what is already verified:
Relevant code, standards, context, source artifacts:
Assigned worktree absolute path / branch / expected artifact:
Checkout verification and workspace constraints for any child agents:
Decisions and permissions applicable to this assignment:
Human review or stop conditions:
Handoff: assignment identity, result, exact artifact version or input snapshot,
verification method/environment and evidence, limitations, and any next decision
or dependent work. State what remains unverified.
```
