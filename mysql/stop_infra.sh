#!/bin/bash

set -eou pipefail

echo "Stopping infrastructure..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
docker compose -f "$SCRIPT_DIR/infrastructure/compose.yaml" down

echo "Infrastructure stopped."