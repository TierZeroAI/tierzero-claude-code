---
name: tierzero-investigate
description: The entry point for any production or infrastructure problem — deployment failures, errors, latency regressions, traffic anomalies, alerts, or anything misbehaving in live systems. Use when the user wants to understand what's happening in prod, check the status of an investigation, ask about a service's behavior, kick off a root-cause investigation, query TierZero (also referred to as t0, tz, or tzero) for production context, or debug any change where real production data would inform a better answer. Handles the full investigation lifecycle from discovery through analysis.
arguments:
  - name: query
    description: What you want to investigate
    required: false
allowed-tools:
  - tierzero_ask
  - tierzero_fetch_context
  - Bash(open:*)
  - Bash(xdg-open:*)
triggers:
  - (tierzero|t0|tz|tzero).?ask
  - (tierzero|t0|tz|tzero).?investigate
  - investigate.?prod
---

# TierZero: Production Telemetry Skill

Query production telemetry data through TierZero's MCP server to inform debugging, incident investigation, feature design, and code review.

## When to trigger

TRIGGER when: debugging a production issue, investigating an incident or alert, designing a new feature, refactoring code where you need to know who/what calls the affected paths, reviewing a PR where production behavior would change your verdict, or any task where understanding real production behavior (traffic patterns, error rates, latency, usage) would inform a better decision. Use proactively — don't wait to be asked.

DO NOT TRIGGER when: writing pure unit tests, updating documentation, or tasks with zero production relevance.

## How to invoke

This plugin registers TierZero as an MCP server (`tierzero`). Call the MCP tools directly — do **not** shell out to `curl` or wrap them in scripts.

Primary tool: `tierzero_ask`

- Pass a single `query` argument (plain English) describing what you want to know.
- Be specific: name the service, give a time window, describe the symptom.
- The tool runs the investigation server-side and returns the grounded answer with evidence sources.

## Writing good queries

A good query for `tierzero_ask`:

- Names the service or component (e.g. `payment-service`, not "the API")
- Specifies a time window (e.g. "last 30 minutes", "since 14:00 UTC", "during the deploy at 13:42")
- States the symptom (errors, latency, drop in traffic, unexpected log line)
- Mentions the integration if you know it (Datadog, Sentry, GitHub Actions, etc.)

Examples:

- `What errors occurred in payment-service in the last hour?`
- `Show p95 latency for /api/checkout over the last 24h and flag anomalies.`
- `Did any GitHub Actions workflows for the api repo fail today?`
- `Has the rate of 5xx on auth-service changed since the deploy at 13:42 UTC?`

## After the call

- Summarize findings tied back to the user's current task
- Cite the integration the data came from (Datadog logs, Sentry issue, etc.) when relevant
- If the result returns a TierZero investigation or chat URL, surface it so the user can drill in
- If the result is empty or an integration isn't connected, say so and suggest what to connect

## Authentication

OAuth is automatic. On first use Claude Code will prompt you to authorize the TierZero MCP server in a browser — log in, consent, done. The token persists in Claude Code.

**If an authorization URL surfaces** (because the user hasn't authed yet, or the token expired), do NOT print the URL and ask the user to copy it. Claude Code's terminal wraps long URLs across multiple lines, splicing newlines into the copied text and breaking the paste. Instead, run it through the system browser opener:

- macOS: `open '<authorization_url>'`
- Linux: `xdg-open '<authorization_url>'`

Quote the URL — the OAuth params contain `&` and `=` which the shell will mangle without quotes. After running, tell the user "Browser opened — log in to TierZero and consent. The MCP server will reconnect automatically once auth completes."

If a tool call fails with an authentication error and you don't have an auth URL in hand, tell the user to run `/mcp` and re-authorize the `tierzero` server.
