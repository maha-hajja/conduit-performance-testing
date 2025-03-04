#!/bin/bash

set -eou pipefail

echo "Cleaning up data..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

docker container prune -f
docker volume prune -f --filter all=true

INFRA_DATA_DIR="$SCRIPT_DIR/infrastructure/data/"
echo "Deleting infrastructure data directory: $INFRA_DATA_DIR"
sudo rm -rf "$INFRA_DATA_DIR"

echo "Data clean-up finished."