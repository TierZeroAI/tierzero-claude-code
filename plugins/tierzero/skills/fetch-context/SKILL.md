---
name: fetch-context
description: Fetch TierZero context (conversations, investigations, artifacts) by URL or ID
arguments:
  - name: input
    description: A TierZero URL or artifact UUID
    required: true
  - name: include_sources
    description: Whether to include source metadata (default false)
    required: false
---

# TierZero: Fetch Context

Fetch conversation, investigation, or artifact data from TierZero by URL or artifact UUID.

## Supported Inputs

- **Chat URL**: `https://app.tierzero.ai/chat/c/<GlobalID>`
- **Investigation URL**: `https://app.tierzero.ai/investigations/<GlobalID>`
- **Artifact UUID**: `bf904904-afdc-4cf2-94d8-76a4a8bb4f75`

## How to Execute

Paths below are relative to this skill directory.

```bash
scripts/tierzero_fetch_context.sh '<url_or_artifact_id>' [true|false]
```

The second argument controls `include_sources` (default: `false`).

### Approval-Friendly Prefixes

The following command prefixes are used by this skill:

- `scripts/tierzero_fetch_context.sh`

## After Execution

- Parse the JSON response and present relevant information to the user
- For conversations: messages with messageType and output
- For investigations: the outputJson result
- For artifacts: the artifact value and type
