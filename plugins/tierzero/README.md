# TierZero Plugin

Access production telemetry through TierZero's unified API.

## Requirements

- A TierZero account with connected integrations
- `TIERZERO_PAT_TOKEN` environment variable set

Get your token from: https://auth.tierzero.ai/account/api_keys/

## Usage

### `/tierzero` Command (Recommended)

Run investigations in the background so you can continue working:

```
/tierzero What errors occurred in payment-service in the last hour?
```

The investigation runs in the background. Use `/tasks` to check status.

## Capabilities

Query your production telemetry data including:
- Logs, metrics, traces from Datadog, New Relic, CloudWatch, Grafana Cloud, Sentry
- CI/CD data from BuildKite, GitHub Actions
- Documentation from Confluence, Notion, Slack
- Workflow data from Temporal
