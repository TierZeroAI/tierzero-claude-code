# TierZero Plugin

Access production telemetry through TierZero's MCP server.

## Requirements

A TierZero account with at least one integration connected (Datadog, New Relic, CloudWatch, Grafana Cloud, Sentry, GitHub, BuildKite, Temporal, Confluence, Notion, Slack, etc.).

## Authentication

OAuth — no tokens, no env vars. On first use Claude Code prompts you to authorize the `tierzero` MCP server in a browser. Log in, consent, done. The token persists in Claude Code.

To re-authorize or revoke, run `/mcp` and manage the `tierzero` server.

## Usage

### Run an investigation

Just ask:

```
What errors occurred in payment-service in the last hour?
```

The agent calls the `tierzero_ask` MCP tool and summarizes the result.

### Load saved context

Paste a TierZero URL or artifact UUID into the chat:

```
https://app.tierzero.ai/investigations/SW52ZXN0...
bf904904-afdc-4cf2-94d8-76a4a8bb4f75
```

The `tierzero-fetch` skill triggers automatically.

### Teach a fact

Tell the agent to save durable knowledge:

```
Remember that payment-service uses a connection pool of 20 to postgres-primary.
```

The `tierzero-teach` skill calls `tierzero_save_snippet` and confirms the outcome. Saved snippets are shared with the whole team and surfaced in future TierZero investigations.

## Capabilities

- Query logs, metrics, traces from Datadog, New Relic, CloudWatch, Grafana Cloud, Sentry
- CI/CD data from BuildKite, GitHub Actions
- Documentation from Confluence, Notion, Slack
- Workflow data from Temporal
- Save durable knowledge (facts, best practices) to the Context Engine
