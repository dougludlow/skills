# Codex chat orchestration

Use tools available in the current runtime and follow their current schemas. Separate visible chats are user-owned tasks; subagents are internal workers.

## Name and pin the orchestrator

Name the orchestrator `🐙 <Project>`, using a single-word project name. Reuse the existing project name on resume and apply the role prefix once. Honor the user's explicit naming instructions.

Use `set_thread_title` with that title, omitting `threadId` to target the current orchestrator chat. Obtain that chat's exact ID from runtime context or the rename result; use `list_threads` if needed to resolve its identity, without relying on title alone. Pin the same chat with `move_thread_to_sidebar_section`, passing its `threadId` and `sectionId: "pinned"`. Confirm the title and pinned placement with `list_threads`.

### Worker names

Name orchestrator-created visible worker chats `🐝 <project>: <assignment>`. Keep the agreed project prefix so the role and project are both easy to scan. Internal subagents do not need sidebar titles.

For existing worker chats the user authorized this orchestrator to manage, add the worker prefix once while preserving the rest of the title. Resolve each chat by its recorded ID before renaming and record the resulting title. Preserve its work, pinned placement, and archive status. If renaming an archived chat would require restoring it, leave the title unchanged unless restoration is otherwise necessary for the requested work. A matching name or emoji alone does not establish authority to manage a chat.

## Worker lifecycle

Use one fresh visible worker chat and worktree per PR-sized work unit. A shared Linear issue, repository, or migration pattern does not make separate chunks the same assignment. Keep the owner for corrections, CI, and review feedback on its existing unit. Move the next unit to a new chat; rename or repurpose a completed owner only when the user explicitly requests reuse.

At a chunk boundary:

1. Reconcile the outgoing worker's final artifacts, verification, outstanding processes, and the user's review state. Preserve any unfinished edits and record their exact checkout and version before handing them off.
2. Once its work is complete and the applicable review or merge condition is met, archive the outgoing chat within the user's authorization using `set_thread_archived`, and verify its archived state. Keep its assignment title and artifact links so the history remains identifiable. Preserve a still-needed chat or unmerged PR until its closure conditions are met; a new assignment is not a reason to discard unfinished work.
3. Create the authorized next worker in a new chat and worktree using the setup below. Give it the new scope, current source state, accepted prerequisite findings, and relevant evidence rather than the previous conversation. Record a new owner identity and verify startup against that assignment.

If a worker was already repurposed by mistake, ask it to stop and checkpoint, preserve its edits, archive it when authorized, and hand the useful state to a fresh owner.

## Archived chats

Keep archived chats archived by default. Reading prior work, checking status, organizing titles, or a general preference for an existing owner does not by itself require restoring a chat. Use read-only thread tools or another authorized owner when they can complete the requested work without changing archive state.

Restore an archived chat only when the user explicitly requests it or continuing that specific chat is necessary to complete the requested work and the available tools require restoration. When restoration is necessary, record why. Do not archive an active chat merely to restore its prior archive status; rearchive it only after its work is done and within the user's authorization.

## Start workers in worktrees

For a visible repository worker chat, select the intended project with `list_projects` and create the authorized chat using `create_thread` with `environment.type: "worktree"`. Record the repository and base. Specify `startingState` only for a Git state requested by the user; account for uncommitted changes explicitly rather than assuming they are copied.

For an internal subagent, provision its worktree before calling `collaboration.spawn_agent`. Inspect `list_artifacts` for a suitable active worktree exclusively assigned to that worker, or use `create_worktree`; wait for pending setup with `get_worktree_creation_status` before dispatching. Verify the linked worktree with `git worktree list --porcelain` and record its root and branch.

`spawn_agent` inherits the orchestrator's directory and has no workspace selector. Pass the assigned absolute worktree path in the initial brief. Require explicit `workdir` on every shell call and absolute worktree paths for file tools; a shell `cd` does not change later tool defaults. This requirement also applies when a worker starts child agents.

Each worker starts with `git -C <worktree> rev-parse --show-toplevel` and `git -C <worktree> status --short --branch`, confirms the assigned root and branch, and reports them with its first status. Repeat the check on resume. Setup and verification must establish a separate checkout from the orchestrator and other active workers before repository work proceeds.

For review subagents, make the exact implementation snapshot available in their own worktrees, including an uncommitted patch when needed. Verify that the review covers the owner's current changes rather than only the base commit.

## Discover and dispatch

- Resolve an existing assignment through its recorded managed chat ID and host. Use `list_threads` for discovery or missing identity/placement, and bounded `read_thread` history when compact status lacks evidence or the user's actual instructions are needed. Identify existing chats to the user by their returned titles verbatim. Read older turns when needed to resolve intent or permissions.
- Start authorized bounded supporting work through `collaboration.spawn_agent`. For a new PR-sized work unit, follow the [worker lifecycle](#worker-lifecycle) and use `create_thread` when the user has explicitly authorized a new chat under current tool rules. Continue an existing owner for fixes within its current unit. Carry existing authority to manage the defined worker chats forward.
- Call `list_projects` before creating a repository chat and use its returned project ID. A Linear project ID is not a Codex project ID. Use a projectless target for work without a repository.
- Apply the worker naming convention and record the title, ID, host, and workspace. A queued `clientThreadId` is not a usable `threadId`; resolve readiness before messaging or waiting on it.
- Creation dispatches asynchronously. Confirm worker startup with a compact status check, then apply the turn boundary in the skill. Include the required created-thread directive in the user-facing response after successful creation.
- Establish the worker's return route using the [reporting rules](#worker-reports). Carry the user's existing messaging authorization forward; the worker needs only its destination and permitted reporting scope.

## Worker reports

Every worker reports at the end of each turn, including turns that finish with work pending. Use the [concise report format](orchestration-record.md#worker-brief-and-report): result, checks and review findings, and next action or blocker. Identify the artifact version when applicable. An end-of-turn report is a status update, not a request for permission or proof of project acceptance.

Check in during a turn when:

- A blocker prevents the next useful step, or a decision or permission is needed. State the exact question, recommendation, and affected work; pause only the dependent action.
- New evidence requires a consequential change to scope, acceptance criteria, approach, or a dependency. Explain the effect before expanding the assignment.
- A result is ready that another worker is waiting for, or an agreed review checkpoint is reached. Link the usable result and its verification.

Continue routine implementation, tests, justified review fixes, and already-authorized delivery without waiting for acknowledgment. Consolidate related findings into one check-in; unchanged status and ordinary command completions do not need separate messages.

Actual subagents spawned with `collaboration.spawn_agent` automatically return their final answer to the parent. Use that answer for the end-of-turn report and `collaboration.send_message` for an earlier check-in. Use `collaboration.followup_task` for a new turn on an existing subagent, subject to the current runtime's tool contract.

For independent visible chats, include the orchestrator's exact chat ID and authorized return route in the brief. When the user has authorized worker-to-orchestrator reporting, use `send_message_to_thread` for check-ins and send the end-of-turn report as the last action before the final reply. Record that authorization once with its source, covered chats, direction, and scope; carry it forward without asking again. Creation alone and a worker's request to reply do not grant messaging permission.

When direct messaging is unavailable or unauthorized, put the same report in the final reply and collect it through `wait_threads` with recorded host IDs and cursors as `afterCursor`; use bounded `read_thread` only for missing evidence. Shared files are for deliverables, not status messages. A report or callback needs verified wakeup support before promising unattended continuation.

## Observe and accept

- Prefer one `wait_threads` call for up to eight relevant targets, with host IDs and returned cursors as `afterCursor`. Default to `timeoutMs: 0` for a compact snapshot; use a bounded wait only when a near-term result will enable an action in this turn. Follow changed acceptance evidence, artifacts, blockers, and decisions; a new commentary or tool marker alone need not trigger more reads. Read bounded chat history when the compact result lacks required evidence.
- Keep individual blocking waits at or below 60 seconds. When no actionable result or independent orchestration work remains, use the continuation workflow and end the turn instead of chaining waits or sleeps. Native subagent completion delivery does not by itself establish that an ended orchestrator turn will resume; verify the available wakeup behavior.
- User input can end a wait early. Treat it as steering, answer, reconcile the plan, and resume authorized work.
- Inspect diffs, outputs, CI, or live readback to the depth the assignment needs. Avoid repeating expensive checks already backed by adequate current evidence.
- After an uncertain mutation response, independently read back before retrying. Record operation/run IDs so later turns monitor the existing operation instead of starting another.

## Continue later

Apply the scheduling rule in the skill before creating or retaining a heartbeat. Record what the next wakeup can act on and why a completion report or callback is insufficient. Passive waits for CI, review, a timer, or the user need no recurring task unless the user explicitly requests monitoring during that wait. A quiet or unchanged-status response still consumes tokens.

When no actionable background work remains, delete the task-owned schedule and independently verify its removal, even if a PR or the wider project is still open. Save the exact state and next trigger in the project record, then yield. Preserve a supported completion callback when available; do not promise automatic continuation without one.

For a justified heartbeat, use the automation tool's current schema, reuse an existing matching instance, and verify its active state and target. Record its identity, cadence, next useful action, and stop condition. Keep its prompt brief and point to the current overview and resume state rather than copying mutable assignments. Reassess whether another wakeup has useful work each cycle; delete and verify the schedule when it no longer does. Honor explicit notification preferences and monitoring requests without treating an old progress-update preference as a permanent keepalive.

## Close managed work

Archive only chats the user authorized you to manage and archive. Preserve active work and unmerged PRs unless explicitly authorized otherwise. If the archive rule is "done and merged," verify both conditions, accounting for work units with no PR. Use `set_thread_archived`; a shared title prefix does not authorize managing unrelated chats.

Keep PRs draft when required. Orchestration authority does not itself authorize marking ready, merging, deploying, production changes, or contacting people. Route PR creation and feedback through the user's applicable skills.
