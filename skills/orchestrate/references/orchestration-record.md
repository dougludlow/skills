# Orchestration record

Keep one current overview that can be recovered without reading chat transcripts. Use the existing Linear project or issue for requirements, decisions, and project progress. Keep chat identities, worktrees, observation cursors, and continuation details in a suitable task-local record when they do not belong there. Create a saved artifact only when the user requests or authorizes one; otherwise retain the compact state in chat. Link the two when both exist and avoid copying the plan.

Use only fields that affect orchestration:

```text
Goal and delivery boundary:
Authoritative plan / requirements version:
Acceptance criteria and current milestone:
Material decisions / permissions and their human source:
Standing orchestrator-to-worker and worker-to-orchestrator communication grant / human source:
Orchestrator chat ID:
Active assignments: outcome, dependency, worker chat ID / host,
  worktree / branch, PR / current head, state, next action.
Evidence: acceptance criterion, reviewed version, result / gaps, link.
Monitoring: check, owner, latest observation / cursor, next trigger.
Continuation: supported mechanism, identity, stop condition.
Next action / decision and owner:
```

Refresh current state after material changes. Move superseded detail out of the overview while retaining useful evidence links and its original version. A PR head, an uncommitted snapshot, and a plan revision are different inputs; record whichever the claim depends on. Read older evidence only for a changed input, disagreement, or acceptance decision that requires it.

## Assignment brief

Give a worker only what changes how it should perform this assignment. Use the absolute skill path so it can read its contract in a new chat.

```text
Read <absolute path to implement/references/non-negotiables.md> before doing the assignment.
Read <absolute path to implement/SKILL.md> and use it for this assignment.

Deliver: <observable outcome and this PR's scope>.
Plan: <specific implementation plan or accessible section and revision>.
Context: <repository guidance, prerequisites, and relevant decisions>.
Checkout: <assigned repository, worktree, branch, and base>.
Acceptance: <required behavior and evidence>.
Authority: <delivery actions already authorized and review boundaries>.
Communication: <standing user grant for project messages in both directions
  between the orchestrator and its workers, with the verifiable human source>.
Report: Send status, questions, blockers, and results directly to
  <orchestrator chat ID / host> under that grant, without repeated approval.
```

Keep project-wide bookkeeping in this record.

## Worker report

Request a short report with links instead of transcripts:

```text
Result: <behavior delivered and PR / exact version>.
Evidence: <acceptance checks, independent reviews, findings addressed,
  and remaining gaps>.
Next: <next action, dependency, or decision needed>.
Project change: <material user steering or changed requirement, if any>.
```

A report can establish a useful intermediate result without establishing acceptance. Preserve the criterion, version, method, and actual outcome from `verify`; a missing reviewer or blocked check remains a coverage gap. Keep returned cursors and processed report pointers with the assignment so resuming does not repeat completed actions.
