#!/bin/bash

set -eou pipefail


echo "Starting infrastructure..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
docker compose -f "$SCRIPT_DIR/infrastructure/compose.yaml" up --wait --wait-timeout 20

# Get broker health status
BROKER_HEALTH=$(docker inspect --format='{{.State.Health.Status}}' broker || echo "unknown")

# Always print the statuses
echo "Broker Health: $BROKER_HEALTH"

# Check if broker is healthy
if [[ "$BROKER_HEALTH" != "healthy" ]]; then
    echo "Error: Container 'broker' is not healthy."
    exit 1
fi

echo "Infrastructure started."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$SCRIPT_DIR/infrastructure/post_init.sh" ]]; then
    echo "Running post_init.sh"
    "$SCRIPT_DIR/infrastructure/post_init.sh"
fi
