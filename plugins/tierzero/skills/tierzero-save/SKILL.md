---
name: tierzero-save
description: Save a snippet to TierZero's Context Engine — organizational memory that persists across sessions and is shared with the whole team. Use when the user asks you to remember, teach, or save something to TierZero (also referred to as t0, tz, or tzero), or when you've discovered durable knowledge worth retaining (service details, ownership, debugging techniques, conventions).
arguments:
  - name: content
    description: What to save (the fact or best practice)
    required: false
  - name: scope
    description: When or where it applies
    required: false
allowed-tools:
  - tierzero_save_snippet
  - tierzero_ask
  - tierzero_fetch_context
  - Bash(open:*)
  - Bash(xdg-open:*)
triggers:
  - (tierzero|t0|tz|tzero).?save
  - (tierzero|t0|tz|tzero).?remember
  - (tierzero|t0|tz|tzero).?teach
  - remember.?this.?(for|in).?(tierzero|t0|tz|tzero|next time|the team|future)
  - save.?(this|that|it).?to.?(tierzero|t0|tz|tzero|context|memory)
  - teach.?(tierzero|t0|tz|tzero)
---

# TierZero: Save Snippet

Save durable knowledge to TierZero's Context Engine so future investigations and answers — for the whole team — can use it.

## When to trigger

TRIGGER when: the user explicitly asks to save, remember, or teach something to TierZero; the user says "remember this for next time" or "save this to context"; or you've uncovered a durable fact during an investigation that the user confirms is worth retaining.

DO NOT TRIGGER when: the information is ephemeral (a one-off metric value, a transient error count), the user hasn't confirmed they want it saved, or the content is speculative / unverified.

## How to invoke

This plugin registers TierZero as an MCP server (`tierzero`). Call the MCP tool directly — do **not** shell out to `curl` or wrap it in scripts.

Tool: `tierzero_save_snippet`

Arguments:

- `content` (string, required): The snippet body — a clear, self-contained piece of knowledge. Include exact names, identifiers, queries, or commands. Write it so someone reading it months from now, with no chat context, understands it fully.
- `scope` (string, required): When or where this snippet applies. Describe the service, system, team, or situation. Normalize it from the conversation context.
- `memory_type` (string, optional, default `"FACT"`):
  - `"FACT"` — observable information about the systems (service/infra details, ownership, configuration, current state).
  - `"BEST_PRACTICE"` — recommended approaches, conventions, or debugging procedures.

## Writing good snippets

A good snippet is:

- **Self-contained** — makes sense without the conversation that produced it
- **Specific** — names the service, metric, query, team, or identifier exactly
- **Durable** — still true next month (avoid timestamps, transient counts, "currently")
- **Actionable** — tells the reader something they can use during an investigation

Examples:

| content | scope | memory_type |
|---------|-------|-------------|
| `payment-service uses a connection pool of 20 to postgres-primary. Under sustained load (>500 rps) the pool exhausts and requests queue, manifesting as p99 latency spikes above 2s.` | `payment-service / postgres connectivity` | `FACT` |
| `To debug Kafka consumer lag in order-processor, check the consumer_lag_records metric in Datadog grouped by partition. Lag on a single partition usually means a slow message handler, not a broker issue.` | `order-processor / Kafka consumer debugging` | `BEST_PRACTICE` |
| `The auth-service rate limiter is configured at 100 req/s per IP in the edge-proxy (envoy.yaml), not in the service itself. Changing the service code won't affect rate limits.` | `auth-service / rate limiting` | `FACT` |

Bad snippets:

- ❌ `There were 142 errors in the last hour` — ephemeral, will be stale immediately
- ❌ `The service is broken` — vague, not actionable
- ❌ `Check Datadog` — too generic, doesn't say what to check or where

## Handling the response

The tool reports the **real outcome** — relay it honestly:

- **"Saved to memory…"** — confirm to the user and share the Context Engine link if one is returned. Note that the snippet becomes available after backend processing (a few minutes).
- **"Not saved: …"** — tell the user why (content empty, too long) and suggest how to fix it. Do not claim it was saved.
- **"ERROR: …"** — something went wrong server-side. Tell the user and suggest retrying.

## Proactive saving

After completing an investigation with `tierzero_ask`, if you uncovered durable facts or debugging techniques, you may **suggest** saving them — but always ask the user first. Frame it as: "I found that [X]. Want me to save this to TierZero's Context Engine so your team has it for next time?"

Do not save anything without the user's confirmation.

## Authentication

OAuth is automatic. On first use Claude Code will prompt you to authorize the TierZero MCP server in a browser — log in, consent, done. The token persists in Claude Code.

**If an authorization URL surfaces** (because the user hasn't authed yet, or the token expired), do NOT print the URL and ask the user to copy it. Claude Code's terminal wraps long URLs across multiple lines, splicing newlines into the copied text and breaking the paste. Instead, run it through the system browser opener:

- macOS: `open '<authorization_url>'`
- Linux: `xdg-open '<authorization_url>'`

Quote the URL — the OAuth params contain `&` and `=` which the shell will mangle without quotes. After running, tell the user "Browser opened — log in to TierZero and consent. The MCP server will reconnect automatically once auth completes."

If a tool call fails with an authentication error and you don't have an auth URL in hand, tell the user to run `/mcp` and re-authorize the `tierzero` server.
