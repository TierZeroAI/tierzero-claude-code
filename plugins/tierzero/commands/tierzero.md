---
name: tierzero
description: Query production telemetry through TierZero (runs in background)
arguments:
  - name: query
    description: What you want to investigate
    required: true
---

Use the Bash tool to call the TierZero MCP server directly via curl, running in the background.

**Requirements:**
- Set `run_in_background: true`
- Use curl to POST to the MCP endpoint
- Include both JSON and SSE Accept headers

Example Bash tool call:

```json
{
  "command": "curl -s -N -X POST \"https://api.tierzero.ai/mcp/\" -H \"Authorization: Bearer $TIERZERO_PAT_TOKEN\" -H \"Content-Type: application/json\" -H \"Accept: application/json, text/event-stream\" -d '{\"jsonrpc\":\"2.0\",\"method\":\"tools/call\",\"params\":{\"name\":\"tierzero_ask\",\"arguments\":{\"query\":\"<USER_QUERY_HERE>\"}},\"id\":1}'",
  "description": "Query TierZero: <brief description>",
  "run_in_background": true
}
```

Replace `<USER_QUERY_HERE>` with the user's actual query (properly JSON escaped - escape quotes and backslashes).

After spawning, tell the user:
- The query is running in the background
- They can use `/tasks` to check status
- They'll be notified when it completes
