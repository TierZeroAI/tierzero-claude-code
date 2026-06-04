---
name: save
description: Save a fact or best practice to TierZero's Context Engine so your team's future investigations can use it.
---

# /save

Save a snippet to TierZero's organizational memory (Context Engine).

The arguments after `/save` are the knowledge to save.

## Steps

1. Treat everything the user typed after `/save` as the snippet `content`.
2. If the content is empty, ask the user what they want to save, then stop.
3. Infer an appropriate `scope` from the conversation context — describe when or where this knowledge applies (e.g., the service, system, or situation).
4. Choose a `memory_type`: use `"FACT"` for observable details about systems (default), or `"BEST_PRACTICE"` for recommended approaches or conventions. If in doubt, default to `"FACT"`.
5. Call the `tierzero_save_snippet` tool on the `tierzero` MCP server with `content`, `scope`, and `memory_type`.
6. Relay the outcome honestly — only tell the user it was saved if the tool confirms it. If the response says "Not saved", explain why and suggest how to fix it.
7. If the call fails with an authentication error, run `/mcp` and re-authorize the `tierzero` server, then retry.

## Tips for a good snippet

- Write it so someone reading it months from now, with no chat context, understands it
- Include exact service names, metric names, identifiers, or commands
- Avoid ephemeral data (transient counts, timestamps, "currently")

## Examples

- `/save payment-service uses a connection pool of 20 to postgres-primary and exhausts under sustained load above 500 rps`
- `/save To debug Kafka consumer lag in order-processor, check consumer_lag_records in Datadog grouped by partition`
- `/save auth-service rate limiter is configured at 100 req/s per IP in the edge-proxy envoy.yaml, not in the service itself`
