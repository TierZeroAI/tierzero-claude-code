#!/usr/bin/env bash
set -euo pipefail

INPUT="$1"
INCLUDE_SOURCES="${2:-false}"

if [ -z "${TIERZERO_PAT_TOKEN:-}" ]; then
  echo "Error: TIERZERO_PAT_TOKEN environment variable is not set." >&2
  echo "Get your token at https://app.tierzero.ai/settings/tokens" >&2
  exit 1
fi

if [ -z "$INPUT" ]; then
  echo "Error: No URL or artifact ID provided." >&2
  echo "Usage: tierzero_fetch_context.sh '<url_or_artifact_id>' [true|false]" >&2
  exit 1
fi

PAYLOAD=$(jq -n \
  --arg url "$INPUT" \
  --argjson include_sources "$INCLUDE_SOURCES" \
  '{
    jsonrpc: "2.0",
    method: "tools/call",
    params: {
      name: "tierzero_fetch_context",
      arguments: { url: $url, include_sources: $include_sources }
    },
    id: 1
  }')

curl -s -N -X POST "https://api.tierzero.ai/mcp/" \
  -H "Authorization: Bearer $TIERZERO_PAT_TOKEN" \
  -H "Content-Type: application/json" \
  -H "Accept: application/json, text/event-stream" \
  -d "$PAYLOAD"
