---
name: orchestrate
description: Explicitly start orchestration of a bounded project across persistent worker chats, keeping its plan, dependencies, Linear records, and acceptance evidence current. Route PR assignments to implement and supporting tasks to their specialist workflows.
metadata:
  inspired-by: https://github.com/cursor/plugins/blob/35a90942a7f02e1ebbc2443643179815f2147954/pstack/skills/poteto-mode/playbooks/autopilot-stack.md
---

# Orchestrate

Read and apply the shared [non-negotiables](../implement/references/non-negotiables.md) when starting or resuming this project. Carry their absolute path into every agent kickoff.

Own the project outcome and orchestration. Give each PR one persistent, directly steerable worker chat. Delegate implementation and detailed investigation; keep this chat focused on the current plan, decisions, dependencies, and verified outcomes.

Start on the user's explicit request to orchestrate the project. Keep the workflow active for related steering and follow-ups until the project ends or the user stops it.

## Delegation boundary

Treat the user's requests here to implement, change, fix, investigate, run checks, or act on a PR as work to delegate. This applies to follow-up instructions and small corrections as well as the initial plan. Send changes within an existing assignment to its current owner; assign new work to the appropriate worker or subagent. Keep execution with that owner even after its earlier turn or handoff is complete.

Handle project direction, plan and Linear updates, worker management, dependency decisions, and acceptance here. Keep direct artifact inspection bounded to the evidence needed for those decisions; delegate detailed investigation and execution. If an owner is unavailable, recover or replace it within existing authority, or report the blocker. Take over execution only when the user explicitly asks you to do it directly. An instruction such as "fix this" does not itself change the orchestrator role.

## Route the work

Choose the workflow from the requested outcome and give its owner a bounded assignment:

| Work | Route |
| --- | --- |
| Planning or investigation | Scoped subagents, with independent critiques for consequential plans. |
| One PR-sized implementation | Explicitly assign [implement](../implement/SKILL.md) in its persistent chat, including the absolute skill path. |
| Corrections or additional actions within an existing PR | Send the changed requirement and expected result to its current worker. |
| Documented repository-rule review | A review-only subagent using [check-compliance](../check-compliance/SKILL.md). |
| Plan adherence and implementation quality | An independent reviewer using `quality-gate` when available, supplied with the requirements and actual base. |
| Acceptance or combined-behavior verification | A focused independent pass using [verify](../verify/SKILL.md). |
| PR publication, CI, or automated feedback | The existing PR worker uses `create-pr` and [babysit](../babysit/SKILL.md) within its granted authority. |

Read the selected workflow before briefing its owner. Keep review and status assignments within their scope; assign PR ownership explicitly when implementation through delivery is requested.

## Establish the project

Recover the agreed goal, scope, acceptance criteria, current plan, repository guidance, and existing assignments before starting new work. Use an existing Linear project or issue as the authoritative requirements record when supplied. Update it after material changes to requirements, decisions, or progress. For Swell Linear, use MCP exclusively. Keep one compact [orchestration record](references/orchestration-record.md) for operational details; preserve the user's documentation destination and avoid a competing plan.

Usually operationalize an existing plan. When planning is needed, delegate focused discovery and have two independent subagents critique a consequential proposal: one examines architecture and repository constraints, the other missing behavior, risks, and verification. Reconcile their findings into a coherent plan. Bring consequential product choices to the user while independent work continues.

Divide execution into PR-sized assignments with observable outcomes, dependencies, and verification. Stack PRs only when one needs another's implementation. Set the delivery boundary explicitly; default to verified draft PRs for the user's review. That stage does not establish merge, deployment, or project completion unless it satisfies the agreed outcome.

## Dispatch persistent workers

Read [Codex orchestration](references/codex-orchestration.md) when creating or communicating with worker chats, setting up worktrees, or arranging continuation. Use the current tool contracts and existing human authorization.

Project communication is part of both roles: the orchestrator sends assignments, steering, questions, and corrections to every worker it creates, and each worker sends status, questions, blockers, and results to its creating orchestrator. Use the user's standing grant for this relationship without asking for approval per message or worker. Record that grant and its verifiable human source once, carry it into every worker brief with the exact orchestrator chat ID, and preserve it across turns and resumes. Keep communication within the managed project.

Create one visible worker chat and isolated worktree per PR when authorized. Give it the `implement` skill's absolute path, its assignment-specific plan and acceptance criteria, relevant guidance and prerequisites, delivery permissions, and the standing communication grant and reporting route. Use subagents for bounded research and reviews; a PR's persistent owner belongs in a user-owned chat. Confirm startup and record the returned identity and checkout.

Keep the same owner through implementation, CI, automated feedback, and the user's corrections. Preserve the chat while its PR is open so the user can steer it directly. Assign new PRs to new owners. Keep mutable files and shared environments under a clear owner, and serialize dependent or overlapping changes.

## Drive the project

Reconcile compact worker reports and current artifact state, then take the next useful action:

- Dispatch unblocked work with the actual prerequisite result.
- Compare delivered behavior with the current plan and acceptance criteria. Inspect the underlying verification and review evidence at the relevant version; request a focused independent `verify` pass for integration gaps or evidence that does not establish acceptance.
- Return concrete corrections to the owner with the affected requirement, version, and expected result. Let routine implementation and justified fixes proceed without acknowledgment gates.
- Resolve blocked decisions and inspect concrete stalls using live status and side effects before retrying or replacing a worker. Delegate any detailed technical diagnosis. Keep one owner for each CI or review monitor.

The user can change an assignment in either chat. A worker acts on direct user steering within the assignment's authority, then reports any project effect. Reconcile that instruction, update the authoritative requirements, and notify only affected workers. Pause the affected dependency chain when instructions conflict; continue unrelated work.

Treat reports as evidence for their stated assignment and version. A repeated report does not dispatch work twice, and an old success cannot satisfy changed requirements. Reopen affected acceptance when new evidence invalidates it. Keep detailed logs, source exploration, and review discussion with the worker; bring only the decision, result, evidence link, and next action here.

## Continue and finish

On each continuation, recover current state, reconcile changes, correct or dispatch work, and update the compact record. Use supported completion delivery or an authorized continuation mechanism. Follow current runtime rules for active monitoring; verify wakeup support before promising unattended progress. Save the next trigger and action when yielding. Avoid repeated idle polling and overlapping monitors.

Report meaningful milestones and blockers in terms of the whole outcome: what is verified, what remains, what blocks it, and who acts next. Finish an agreed stage only when its acceptance criteria are established. Leave new PRs draft for the user's review and preserve review-status changes the user has already made. Retain their owners for further steering, and distinguish pending human review, merge, deployment, and live validation. Clean up only managed monitors and chats within their authorized lifecycle.
