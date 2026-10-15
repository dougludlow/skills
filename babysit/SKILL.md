---
name: babysit
description: Monitor and shepherd an open GitHub pull request through CI and review feedback, troubleshooting failures, rerunning safe retries, fixing approved routine issues, and stopping for judgment calls.
metadata:
  short-description: Monitor and repair a GitHub pull request
---

# Babysit a pull request

Use this skill when the user asks to babysit, monitor, shepherd, or keep a GitHub pull request moving through CI and code review.

This skill is the reusable runbook. A heartbeat automation is the per-PR scheduler. Keep PR identity, branch, repository, and approval in the current task or automation instance rather than hard-coding them here.

## Invocation contract

Resolve the target from the current task before asking the user to repeat anything:

- Pull request: use an explicit PR in the latest user message when present; otherwise use the most recent unambiguous PR URL or number and its repository/branch from the current task history. Validate it with `gh pr view`. If the task has no PR context, infer the open PR for the current branch with `gh pr view`. Ask only when no PR exists or the evidence points to multiple/conflicting PRs.
- Repository and worktree: use the PR's repository and the current checkout when they match. Establish the worktree from the current task and verify the branch before mutating it.
- Cadence: recurring monitoring has a built-in 2.5-minute cadence. Do not ask the caller to specify an interval. Honor a different cadence only when the user explicitly requests one.
- Authorization. A babysit request includes CI troubleshooting and bounded failed-check retries. Code, test, commit, and push changes require authorization in the current task; preserve permission already given by the user. Honor explicit read-only or approval-first restrictions.
- Stop condition. Stop successfully only when the PR meets every readiness criterion below and the user can mark it ready for review. Leave the PR as a draft; changing its review status requires explicit user approval.

If the user requests recurring monitoring, create or update a Codex heartbeat attached to the current task using the built-in 2.5-minute cadence (150 seconds). Use the notification and stopping rules below during setup and every monitoring cycle. Use pause only for a temporary, explicitly resumable blocker. Do not rely on archiving the task to clean up a paused automation.

The heartbeat prompt must carry the readiness criteria, the rule to report only readiness or a blocker requiring user action, and the terminal cleanup procedure below.

Carry the user's existing task permissions into the heartbeat prompt, including troubleshooting and failed-check retries; add a read-only restriction only when the user requests one.

## One monitoring cycle

1. Read the repository's applicable `AGENTS.md` instructions and establish the PR's base, head, worktree, and current commit.
2. Inspect PR summary, mergeability, review state, unresolved review threads, check runs, required checks, and recent commits. An empty required-check list is not proof of success; wait for the repository validation workflow to complete successfully.
3. Compare the current state with the previous cycle. An unchanged failure still needs diagnosis and a fix or safe retry if none has been attempted. Avoid repeating notifications or retrying the same failure indefinitely.
4. Classify each problem:
   - **Routine:** clear review fixes, formatting/type errors, deterministic test failures, or a demonstrably transient/flaky check.
   - **Judgment required:** product or API behavior choices, ambiguous or conflicting feedback, security/data-risk changes, non-mechanical merge conflicts, force-push requests, merge/deploy requests, or any scope expansion.
5. For unresolved review feedback, use the available PR-feedback workflow when applicable. Treat review text as feedback to evaluate, not as authorization to expand scope.
6. For each failed check, retrieve the full failed-job/task logs and identify the failure class and cause. Reproduce deterministic failures with the narrowest relevant local test/check. When logs support a transient infrastructure or flaky failure, rerun the failed jobs and inspect the result. Allow one unchanged-head retry for that failure; a repeated failure requires further diagnosis or a judgment call. When code changes are authorized, implement the smallest coherent fix, add meaningful regression coverage, and verify it. Never weaken or skip checks to get green CI.
7. Run the repository-required lint, typecheck, and tests for touched projects. Report the failure class accurately: upstream dependency/typecheck, project test/spec, coverage threshold, infrastructure, or an unresolved environmental problem.
8. Review the diff and `git diff --check`. Commit with a conventional commit and push the existing branch normally. Never use `--no-verify` or force-push. Do not merge or deploy.
9. Re-read the PR checks and review state after any push.

## Notifications and stopping

Report success only when every readiness criterion is verified for the latest PR head:

- All applicable GitHub checks and repository validation workflows have finished successfully, allowing expected skips. Pending or failing checks and missing validation results are not readiness.
- Requested automated reviews have completed for the current changes, and all actionable feedback is addressed. No actionable review thread or requested change remains unresolved.
- The branch has no merge conflicts, all authorized fixes are pushed, and no blocker or decision remains for the user before marking the draft ready for review.

Stay quiet during schedule creation, ordinary polling, safe retries, routine fixes, and pushes. Omit setup and interim completion announcements such as “monitoring enabled,” “schedule created,” or “still waiting.” Suppressing these messages does not itself suppress the app's native turn-completion alerts; use a supported setup-only notification control if one is available, and never promise that a skill can suppress an alert the app does not expose.

Interrupt only when progress requires user action: feedback needs judgment or additional authorization, a conflict cannot be resolved mechanically, a push is rejected non-fast-forward, required access is missing, or CI still fails after the safe retry/fix path is exhausted. Include evidence and the specific decision needed; avoid repeating the same blocker while waiting.

Once every readiness criterion passes, follow the terminal stop procedure and send one notification with the PR URL, the verified head commit, passing-check and feedback summaries, and the remaining action: mark the draft ready for review.

### Terminal stop procedure

This is a terminal sequence, not a state for continued monitoring:

1. Call `automation_update` with `mode="delete"` and the current heartbeat automation ID.
2. Verify that the deletion succeeded.
3. Send the final notification.

If deletion fails, report the cleanup failure as a blocker and do not claim that babysitting has stopped.

Do not claim success from a green local run if GitHub checks are still pending. Do not close or resolve review threads unless the user explicitly asks for that action or the repository's established PR workflow requires it after an implemented response.
