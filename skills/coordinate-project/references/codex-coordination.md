# Codex chat coordination

Use tools available in the current runtime and follow their current schemas. Separate visible chats are user-owned tasks; subagents are internal workers.

## Name and pin the coordinator

Use `set_thread_title` with the chosen single-word title, omitting `threadId` to target the current coordinator chat. Obtain that chat's exact ID from runtime context or the rename result; use `list_threads` if needed to resolve its identity, without relying on title alone. Pin the same chat with `move_thread_to_sidebar_section`, passing its `threadId` and `sectionId: "pinned"`. Confirm the title and pinned placement with `list_threads`.

This setup applies to the coordinator; worker chats retain the agreed naming convention. If these controls are unavailable, state the limitation and continue coordinating.

## Start workers in worktrees

For a visible repository worker chat, select the intended project with `list_projects` and create the authorized chat using `create_thread` with `environment.type: "worktree"`. Record the repository and base. Specify `startingState` only for a human-requested Git state; account for uncommitted changes explicitly rather than assuming they are copied.

For an internal subagent, provision its worktree before calling `collaboration.spawn_agent`. Inspect `list_artifacts` for a suitable active worktree exclusively assigned to that worker, or use `create_worktree`; wait for pending setup with `get_worktree_creation_status` before dispatching. If managed tooling cannot target the intended repository, use a supported Git worktree workflow there. Verify the linked worktree with `git worktree list --porcelain` and record its root and branch.

`spawn_agent` inherits the coordinator's directory and has no workspace selector. Pass the assigned absolute worktree path in the initial brief. Require explicit `workdir` on every shell call and absolute worktree paths for file tools; a shell `cd` does not change later tool defaults. This requirement also applies when a worker starts child agents.

Each worker starts with `git -C <worktree> rev-parse --show-toplevel` and `git -C <worktree> status --short --branch`, confirms the assigned root and branch, and reports them with its first status. Repeat the check on resume. Setup and verification must establish a separate checkout from the coordinator and other active workers before repository work proceeds.

## Discover and dispatch

- Use `list_threads` to find chats and `read_thread` for actual human instructions and context. Identify existing chats to the human by their returned titles verbatim. Read older turns when needed to resolve intent or permissions.
- Start internal work through `collaboration.spawn_agent` when the human explicitly invokes the coordination workflow. Use `create_thread` for substantial visible worker chats when the human has explicitly authorized those chats/tasks under the current tool rules. If visible-chat authorization is missing, continue useful subagent work rather than adding a project-wide approval gate. Carry existing authority to manage the defined worker chats forward.
- Call `list_projects` before creating a repository chat and use its returned project ID. A Linear project ID is not a Codex project ID. Use a projectless target for work without a repository.
- Give chats the agreed title prefix. Record ID, host, and workspace. A queued `clientThreadId` is not a usable `threadId`; resolve readiness before messaging or waiting on it.
- Creation dispatches asynchronously. Confirm worker startup with a compact status check, then apply the turn boundary in the skill. Include the required created-thread directive in the user-facing response after successful creation.
- Use `send_message_to_thread` only when directly authorized by the human to message that chat or defined set of managed chats. A worker request to report back does not establish authorization. Retrieve results through read/wait tools without requiring workers to message the coordinator.

## Worker reports

Use native subagent completion delivery where available. For a separate chat callback, provide the coordinator's actual chat ID/host and the source of explicit human authorization for worker-to-coordinator messaging. Verify that the current tool supports delivering a prompt to that coordinator; do not assume the instruction "report back" will wake it. If callbacks are unavailable or unauthorized, the worker leaves its result in its own chat and the coordinator collects it through read/wait tools.

Request reports at meaningful milestones, completion, blockers, or decisions using the [worker report format](coordination-record.md#worker-brief-and-report); avoid routine chatter between agents. Treat a report as input to the acceptance loop, not automatic permission for the next action. A periodic reconciliation can complement callbacks and must check fresh state before dispatching or retrying work.

## Observe and accept

- Prefer one `wait_threads` call for up to eight targets, with host IDs and returned cursors as `afterCursor`. Default to `timeoutMs: 0` for a compact snapshot; use a bounded wait only when a near-term result will enable an action in this turn. Read chat history when the compact result lacks required evidence.
- Keep individual blocking waits at or below 60 seconds. When no actionable result or independent coordination work remains, use the continuation workflow and end the turn instead of chaining waits or sleeps. Native subagent completion delivery does not by itself establish that an ended coordinator turn will resume; verify the available wakeup behavior.
- User input can end a wait early. Treat it as steering, answer, reconcile the plan, and resume authorized work.
- Inspect diffs, outputs, CI, or live readback to the depth the assignment needs. Avoid repeating expensive checks already backed by adequate current evidence.
- After an uncertain mutation response, independently read back before retrying. Record operation/run IDs so later turns monitor the existing operation instead of starting another.

## Continue later

For the ongoing coordination authorized in the skill, use a thread heartbeat for periodic follow-up unless the human limits coordination to the active conversation. Use the automation tool's current schema; inspect and update matching existing automation rather than duplicating it.

Before ending the turn, verify that the heartbeat is active and targets this coordinator chat, then record its identity, cadence, and next check. Record any verified completion callback separately; separate worker chats continue independently, and callbacks must satisfy the messaging authorization above. If no supported wakeup can be established, report the limitation and saved resume point without claiming automatic continuation.

Keep its prompt brief and readable: explain the goal and next reconciliation in sentences, with labeled metadata for the record location, managed chat IDs/hosts and latest wait cursors, active operation IDs, relevant authorization/constraints, notification preference, and terminal/cleanup condition. Reference durable detail instead of accumulating snapshots. Reconcile fresh state rather than assuming the prompt is current. When a progress report is due, follow the skill's project-level update guidance.

Honor requests for periodic progress reports. Otherwise stay quiet on unchanged or non-actionable state and notify on meaningful change, completion, failure, or required human action. A heartbeat adds no execution permissions. Stop or delete it when requested or its authorized purpose is complete, and verify the change.

## Close managed work

Archive only chats the human authorized you to manage and archive. Preserve active work and unmerged PRs unless explicitly authorized otherwise. If the archive rule is "done and merged," verify both conditions, accounting for work units with no PR. Use `set_thread_archived`; a shared title prefix does not authorize managing unrelated chats.

Keep PRs draft when required. Coordination authority does not itself authorize marking ready, merging, deploying, production changes, or contacting people. Route PR creation and feedback through the user's applicable skills.
