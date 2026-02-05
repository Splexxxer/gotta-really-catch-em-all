#!/usr/bin/env bash
set -euo pipefail

API_SPEC_URL=${1:-"http://localhost/api/openapi.json"}
OUT_DIR=${2:-"frontend/src/api"}

echo "[stub] Generate client from ${API_SPEC_URL} into ${OUT_DIR}" >&2
