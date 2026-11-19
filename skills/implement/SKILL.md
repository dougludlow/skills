---
name: implement
description: Execute an explicitly assigned PR-sized implementation through plan critique, implementation, independent review, verification, draft-PR delivery, and direct user feedback.
metadata:
  inspired-by: https://github.com/cursor/plugins/blob/35a90942a7f02e1ebbc2443643179815f2147954/pstack/skills/poteto-mode/playbooks/autopilot-full.md
---

# Implement

Read and apply the shared [non-negotiables](references/non-negotiables.md). Carry their absolute path into every agent kickoff.

Start only for an explicit implementation assignment from the user or an authorized orchestrator. Own the assignment and its PR in this chat through implementation, CI, review feedback, and direct user corrections. Resume the same assignment without requiring repeated invocation.

Follow the sequence below. Complete compliance review, implementation critique, and verification before invoking `create-pr` to create the PR.

## 1. Establish the assignment

Read the plan, acceptance criteria, repository guidance, prerequisites, and delivery permissions. Verify the repository root, worktree, branch, and base. Recover existing work and its PR before starting another; preserve unrelated changes.

Resolve ordinary implementation choices from the plan and code. Surface consequential missing behavior or conflicting instructions while independent work continues. Carry existing permissions forward, including the user's standing bidirectional communication grant and its verifiable human source when assigned by an orchestrator. Use that grant without approval per message. Preserve the boundaries on publication, unrelated communication, readiness, merge, deployment, and production changes.

## 2. Critique the plan

Before substantial implementation, have one or two subagents critique the approach against the requirements, architecture, failure cases, and verification. Reuse an applicable earlier critique when its inputs are unchanged. Address justified findings and surface consequential scope or behavior changes before proceeding.

## 3. Implement and run checks

Implement one coherent PR-sized change using the repository's workflows. Give each writing subagent its own worktree and explicit paths. Run the required checks for the touched projects and inspect the diff. Keep dependent PRs limited to work that needs an earlier implementation.

## 4. Review the implementation

Have separate subagents review the same stable version:

- Use `check-compliance` to assess applicable documented rules and workflow requirements currently due.
- Critique plan adherence, correctness, scope, design, and test quality. Use `quality-gate` when available, supplying the plan and actual review base.

Give reviewers the requirements, governing guidance, exact base and head, and any uncommitted snapshot. They inspect the actual changes. Give executing reviewers isolated checkouts containing that version.

Evaluate each finding, fix justified problems, and explain rejected findings with evidence. Surface consequential disagreements. After fixes, rerun affected checks and obtain focused re-review; substantial behavior or design changes need broader review.

## 5. Verify the result

Use `verify` to establish the acceptance criteria against the reviewed implementation and record the version and evidence. For substantial behavioral changes, have an independent subagent exercise the critical acceptance path. Keep this pass distinct from the review-only `quality-gate` task. For non-code work, check the actual deliverable.

If verification requires a fix, return to implementation and refresh the affected reviews and verification. Missing required review or verification evidence is a blocker to PR creation; report the gap and continue independent work.

## 6. Create the draft PR

After the preceding steps pass, use the existing `create-pr` skill to commit, push, and create the draft PR within the assignment's authority. If PR preparation changes the implementation, refresh affected review and verification before publication. Follow repository requirements for attaching the PR to this chat and requesting automated review.

## 7. Babysit and hand off

Use `babysit` for GitHub CI and automated feedback. Keep this chat as the sole monitoring owner. For corrections, repeat the affected implementation, review, and verification steps before publishing the updated changes to the same PR. Preserve the user's review-status decisions, including when they have already marked it ready for teammate review.

Report the PR and exact head, acceptance evidence, independent-review outcomes, finding dispositions, and remaining gaps or decisions. For an orchestrator-created assignment, send the report directly to its recorded chat ID under the standing communication grant. If delivery is unavailable, leave the report here for collection and identify the blocker. For a standalone assignment, report here. Check in earlier for blockers, changed requirements, or results that unblock others; routine progress needs no acknowledgment.

Remain available for direct user steering after handoff. Report effects on shared requirements or dependencies to the orchestrator, which owns project-wide tracking. Readiness, merging, and archival remain separate user decisions.
