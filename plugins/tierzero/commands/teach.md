---
name: teach
description: Save a fact or best practice to TierZero's Context Engine so your team's future investigations can use it.
---

# /teach

Save a snippet to TierZero's organizational memory (Context Engine).

The arguments after `/teach` are the knowledge to save.

## Steps

1. Treat everything the user typed after `/teach` as the snippet `content`.
2. If the content is empty, ask the user what they want to save, then stop.
3. Infer an appropriate `scope` from the conversation context — describe when or where this knowledge applies.
4. Choose a `memory_type`: use `"FACT"` for observable details about systems (default), or `"BEST_PRACTICE"` for recommended approaches or conventions.
5. Call `tierzero_save_snippet` on the `tierzero` MCP server with `content`, `scope`, and `memory_type`.
6. Relay the outcome honestly — only tell the user it was saved if the tool confirms it.
7. If the call fails with an authentication error, run `/mcp` and re-authorize the `tierzero` server, then retry.

## Examples

- `/teach payment-service uses a connection pool of 20 to postgres-primary and exhausts under sustained load above 500 rps`
- `/teach To debug Kafka consumer lag in order-processor, check consumer_lag_records in Datadog grouped by partition`
- `/teach auth-service rate limiter is configured at 100 req/s per IP in the edge-proxy envoy.yaml, not in the service itself`
