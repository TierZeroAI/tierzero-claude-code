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

### Save knowledge to the Context Engine

Tell the agent to save a fact or best practice:

```
Remember that payment-service uses a connection pool of 20 to postgres-primary.
```

The `tierzero-save` skill calls `tierzero_save_snippet` and confirms the outcome. Saved snippets are shared with the whole team and surfaced in future TierZero investigations.

## Capabilities

- Query logs, metrics, traces from Datadog, New Relic, CloudWatch, Grafana Cloud, Sentry
- Analyze CI/CD data from BuildKite, GitHub Actions
- Search documentation from Confluence, Notion, Slack
- Inspect workflow data from Temporal
- Save durable knowledge (facts, best practices) to TierZero's Context Engine
