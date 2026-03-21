#!/usr/bin/env bash
set -euo pipefail

QUERY="$1"

if [ -z "${TIERZERO_PAT_TOKEN:-}" ]; then
  echo "Error: TIERZERO_PAT_TOKEN environment variable is not set." >&2
  echo "Get your token at https://app.tierzero.ai/settings/tokens" >&2
  exit 1
fi

if [ -z "$QUERY" ]; then
  echo "Error: No query provided." >&2
  echo "Usage: tierzero_ask.sh '<query>'" >&2
  exit 1
fi

PAYLOAD=$(jq -n \
  --arg query "$QUERY" \
  '{
    jsonrpc: "2.0",
    method: "tools/call",
    params: {
      name: "tierzero_ask",
      arguments: { query: $query }
    },
    id: 1
  }')

curl -s -N -X POST "https://api.tierzero.ai/mcp/" \
  -H "Authorization: Bearer $TIERZERO_PAT_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d "$PAYLOAD"
