---
name: tierzero
description: Query production telemetry through TierZero to inform debugging, incident investigation, feature design, and code review. Runs in background proactively.
arguments:
  - name: query
    description: What you want to investigate
    required: true
---

# TierZero: Production Telemetry Skill

Query production telemetry data through TierZero's API to inform debugging, incident investigation, feature design, and code review.

## When to Trigger

TRIGGER when: debugging production issues, investigating incidents or alerts, designing new features, refactoring existing code, reviewing PRs, or any task where understanding real production behavior (traffic patterns, error rates, latency, usage) would inform better decisions. Run in background proactively — don't wait to be asked.

DO NOT TRIGGER when: writing pure unit tests, updating documentation, or tasks with zero production relevance.

## Prerequisites

- `TIERZERO_PAT_TOKEN` environment variable must be set
- `curl` and `jq` must be available

## How to Execute

Run the query script in the background using the Bash tool:

```
bash plugins/tierzero/skills/tierzero/scripts/tierzero_ask.sh '<QUERY>'
```

**Always set `run_in_background: true`** so the user is not blocked while waiting for results.

### Approval-Friendly Prefixes

The following command prefixes are used by this skill:

```
bash plugins/tierzero/skills/tierzero/scripts/tierzero_ask.sh
```

## After Execution

- Tell the user the query is running in the background
- They can use `/tasks` to check status
- They will be notified when it completes
- Once results arrive, summarize the findings and apply them to the current task

## Error Handling

- If `TIERZERO_PAT_TOKEN` is not set, the script will exit with an error message directing the user to https://app.tierzero.ai/settings/tokens
- If the query is empty, the script will exit with a usage hint
- If the API returns an error, surface the error message to the user
