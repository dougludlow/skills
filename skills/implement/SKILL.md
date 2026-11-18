---
name: implement
description: Execute an explicitly assigned PR-sized implementation through independent review, verification, draft-PR delivery, and direct user feedback. Start only when the user or an authorized orchestrator explicitly assigns this workflow.
metadata:
  inspired-by: https://github.com/cursor/plugins/blob/35a90942a7f02e1ebbc2443643179815f2147954/pstack/skills/poteto-mode/playbooks/autopilot-full.md
---

# Implement

Read and apply the shared [non-negotiables](references/non-negotiables.md) when starting or resuming this assignment. Carry their absolute path into every agent kickoff.

Own this assignment and its PR in this chat. Keep the same checkout and ownership through implementation, CI, automated review, and the user's corrections. The user can steer you directly; routine progress does not need the orchestrator's acknowledgment.

Start this workflow only for an explicit PR implementation assignment from the user or an authorized orchestrator. Ordinary implementation questions, keyword matches, and requests to inspect a PR do not establish that assignment. After assignment, keep the workflow active for corrections to the same PR without requiring repeated invocation.

## Recover the assignment

Read the assignment's plan, acceptance criteria, relevant repository instructions, prerequisites, and delivery permissions. Verify the repository root, worktree, branch, and base before editing. Recover an existing PR and unfinished work before starting another. Follow repository branch conventions and keep unrelated changes intact.

Resolve ordinary implementation details from the plan and code. Ask for consequential missing behavior or conflicting instructions, then continue independent work. For an orchestrator-created assignment, communication with that orchestrator is part of this role: use the user's standing project grant and verifiable human source supplied in the brief to send status, questions, blockers, and results directly to it. Preserve the grant across turns and resumes without asking for approval per message. A worker assignment does not expand authorization to publish, contact people or unrelated chats, mark a PR ready, merge, deploy, or change production data. Carry the user's existing permissions forward.

## Critique the plan and implement

Before substantial implementation, ask one or two subagents to critique the proposed approach against the requirements, repository architecture, failure cases, and verification. Reuse a relevant planning critique when its inputs still apply. Reconcile justified findings; bring material changes in scope or behavior to the user and orchestrator. Keep small, obvious corrections proportionate.

Implement a coherent PR-sized result using the repository's applicable workflows. Give each writing subagent its own worktree and explicit paths. Keep changes independently verifiable, and use a dependent PR only when the assignment requires earlier implementation.

Use `verify` to connect each acceptance criterion to evidence from the actual result. Prefer existing repository checks and verification harnesses. Report a failed or inaccessible check accurately and preserve the uncovered requirement.

## Obtain independent review

Review a stable version of the resulting changes before handoff. Ask separate subagents for:

- Documented-rule review using `check-compliance`, including applicable workflow requirements that are currently due.
- Plan adherence and implementation quality: missing or incorrect behavior, scope drift, design, and meaningful verification. Use `quality-gate` when available and supply the plan and actual PR base explicitly.

Give reviewers the relevant requirements, governing guidance, exact base and head, and any uncommitted snapshot. They must inspect the implementation rather than rely on your summary. Give executing reviewers isolated checkouts containing that version. If subagents or a required source are unavailable, report the review gap rather than claim independent review passed.

For substantial behavioral changes, have an independent subagent use `verify` to exercise the critical acceptance path. Keep that verification distinct from a `quality-gate` review-only brief. It can be a focused pass rather than a repetition of every author check. For non-code work, choose an equivalent check of the actual deliverable.

Weigh findings against the code and requirements. Reproduce claimed runtime failures when practical; documentary or design findings can be established by traced code and governing guidance. Address justified findings and explain rejected ones with evidence. Escalate unresolved consequential disagreements. After changes, rerun affected verification and request focused re-review; substantial behavior or design changes need broader independent review.

## Deliver and remain steerable

Use the existing `create-pr` skill for authorized publication and PR updates. Open and leave the PR as a draft. Follow repository requirements for attaching the PR to this chat and requesting automated review. A draft can be opened early when authorized so CI runs alongside implementation; publication alone is not a completed handoff.

Use `babysit` for CI and automated feedback within the assignment's granted permissions. Keep this worker as the sole monitoring owner. Preserve current behavioral verification and independent review evidence as the PR changes. Green CI does not establish those other results.

Hand back the PR and exact head, acceptance evidence from `verify`, independent-review outcomes and finding dispositions, and remaining gaps or decisions. Keep the report short and link detail. For an orchestrator-created assignment, send the report directly to that orchestrator using its recorded chat ID and the standing project communication grant. If delivery is unavailable, leave the same report in this chat for collection and identify the delivery blocker. For a standalone user assignment, report here without requiring an orchestrator. Send earlier check-ins for blockers, changed requirements, or a result that unblocks another assignment.

Remain available in this chat after handoff. Direct user feedback authorizes the requested correction within its stated scope; act on it and refresh affected evidence. Preserve the user's control of review status, including when they have already marked the PR ready for teammate review. Report changes to shared requirements or dependencies so the orchestrator can reconcile Linear and other workers. Keep project-wide tracking with the orchestrator unless the assignment grants you that responsibility. If directions conflict, surface the conflict and hold only the affected work. Readiness, merging, and worker archival remain separate user decisions.
