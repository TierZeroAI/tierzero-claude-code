---
name: tierzero-teach
description: Save a snippet to TierZero's Context Engine — organizational memory shared with the whole team. Use when the user asks you to remember, teach, or save something to TierZero (also referred to as t0, tz, or tzero), or when you've discovered durable knowledge worth retaining (service details, ownership, debugging techniques, conventions).
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
  - (tierzero|t0|tz|tzero).?(teach|save|remember)
  - remember.?this.?(for|in).?(tierzero|t0|tz|tzero|next time|the team|future)
  - save.?(this|that|it).?to.?(tierzero|t0|tz|tzero|context|memory)
---

# TierZero: Teach a Fact

Save durable knowledge to TierZero's Context Engine so future investigations and answers — for the whole team — can use it.

## When to trigger

TRIGGER when: the user explicitly asks to save, remember, or teach something to TierZero; the user says "remember this for next time"; or you've uncovered a durable fact during an investigation that the user confirms is worth retaining.

DO NOT TRIGGER when: the information is ephemeral (a one-off metric value, a transient error count), the user hasn't confirmed they want it saved, or the content is speculative / unverified.

After completing an investigation with `tierzero_ask`, if you uncovered durable facts or debugging techniques, proactively suggest saving — but always get user confirmation first. Frame it as: "I found that [X]. Want me to save this to TierZero's Context Engine so your team has it for next time?"

## How to invoke

This plugin registers TierZero as an MCP server (`tierzero`). Call the MCP tool directly — do **not** shell out to `curl` or wrap it in scripts.

Tool: `tierzero_save_snippet`

Arguments:

- `content` (string, required): The snippet body — clear and self-contained. Include exact names, identifiers, queries, or commands. Write it so someone with no chat context understands it.
- `scope` (string, required): When/where it applies. Describe the service, system, or situation. Normalize from conversation context.
- `memory_type` (string, optional, default `"FACT"`):
  - `"FACT"` — observable information about the systems (service/infra details, ownership, configuration).
  - `"BEST_PRACTICE"` — recommended approaches, conventions, or debugging procedures.

## Writing good snippets

Examples:

- `content`: "payment-service uses a connection pool of 20 to postgres-primary. Under sustained load (>500 rps) the pool exhausts and requests queue, causing p99 > 2s." / `scope`: "payment-service / postgres connectivity" / `memory_type`: "FACT"
- `content`: "To debug Kafka consumer lag in order-processor, check consumer_lag_records in Datadog grouped by partition. Single-partition lag usually means a slow handler, not a broker issue." / `scope`: "order-processor / Kafka debugging" / `memory_type`: "BEST_PRACTICE"

Avoid saving ephemeral data ("142 errors in the last hour"), vague statements ("the service is broken"), or generic advice ("check Datadog").

## After the call

The tool reports the real outcome — relay it honestly:

- **"Saved to memory…"** — confirm and share the Context Engine link. Note it becomes available after backend processing (a few minutes).
- **"Not saved: …"** — tell the user why (empty, too long) and suggest a fix. Do not claim it was saved.
- **"ERROR: …"** — tell the user and suggest retrying.

## Authentication

OAuth is automatic.

**If an authorization URL surfaces** (because the user hasn't authed yet, or the token expired), do NOT print the URL and ask the user to copy it. Claude Code's terminal wraps long URLs across multiple lines, splicing newlines into the copied text and breaking the paste. Instead, run it through the system browser opener:

- macOS: `open '<authorization_url>'`
- Linux: `xdg-open '<authorization_url>'`

Quote the URL — the OAuth params contain `&` and `=` which the shell will mangle without quotes. After running, tell the user "Browser opened — log in to TierZero and consent. The MCP server will reconnect automatically once auth completes."

If a tool call fails with an authentication error and you don't have an auth URL in hand, tell the user to run `/mcp` and re-authorize the `tierzero` server.
