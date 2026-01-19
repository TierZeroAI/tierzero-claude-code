# TierZero Claude Code Plugin

Official Claude Code plugin marketplace for [TierZero](https://tierzero.ai) - unified production context for AI assistants.

## Installation

1. **Set up your TierZero PAT token**

   Get your Personal Access Token from [https://auth.tierzero.ai/account/api_keys/](https://auth.tierzero.ai/account/api_keys/) and add it to your shell:

   ```bash
   export TIERZERO_PAT_TOKEN="your-token-here"
   ```

2. **Add the TierZero marketplace**

   ```
   /plugin marketplace add TierZeroAI/tierzero-claude-code
   ```

3. **Install the plugin**

   ```
   /plugin install tierzero@tierzero
   ```

## Usage

### `/tierzero` Command (Recommended)

Run investigations in the background so you can continue working:

```
/tierzero What errors occurred in payment-service in the last hour?
```

The investigation runs in the background. Use `/tasks` to check status.

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
