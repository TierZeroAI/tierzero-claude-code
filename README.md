# TierZero Claude Code Plugin

Official Claude Code plugin marketplace for [TierZero](https://tierzero.ai) — unified production context for AI assistants.

## Installation

1. **Add the TierZero marketplace**

   ```
   /plugin marketplace add TierZeroAI/tierzero-claude-code
   ```

2. **Install the plugin**

   ```
   /plugin install tierzero@tierzero
   ```

3. **Authorize on first use**

   The first time the agent calls a TierZero tool, Claude Code opens a browser to authorize the `tierzero` MCP server. Log in to TierZero and consent — the token persists. To re-authorize later, run `/mcp` and manage the `tierzero` server.

## Usage

Just ask:

```
What errors occurred in payment-service in the last hour?
```

The agent calls `tierzero_ask` and summarizes the result.

To load saved TierZero context, paste a chat / investigation URL or an artifact UUID:

```
https://app.tierzero.ai/investigations/SW52ZXN0...
bf904904-afdc-4cf2-94d8-76a4a8bb4f75
```

**Capabilities:**
- Query logs, metrics, traces, and spans from connected integrations (Datadog, New Relic, CloudWatch, Grafana Cloud, Sentry)
- Analyze code repositories and CI/CD pipelines (GitHub, BuildKite, GitHub Actions)
- Inspect workflow executions (Temporal)
- Search knowledge bases (Confluence, Notion, Slack)

## Documentation

- [TierZero MCP Server Documentation](https://docs.tierzero.ai/references/mcp-server)
- [TierZero Documentation](https://docs.tierzero.ai)

## License

MIT
