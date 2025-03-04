#!/bin/bash

set -euo pipefail

# Validate argument count
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <TOOL> <MODE>"
    exit 1
fi

TOOL="$1"
MODE="$2"

# Validate TOOL
if [[ "$TOOL" != "conduit" && "$TOOL" != "kafka_connect" ]]; then
    echo "Error: TOOL must be either 'conduit' or 'kafka_connect'."
    exit 1
fi

# Validate MODE
if [[ "$MODE" != "snapshot" && "$MODE" != "cdc" ]]; then
    echo "Error: MODE must be either 'snapshot' or 'cdc'."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR"/reset_infra.sh

printf "\n\n"
echo "Running $TOOL"
docker compose -f "$SCRIPT_DIR"/"$TOOL"/compose.yaml up --wait --wait-timeout 45

if [[ "$MODE" == "snapshot" ]]; then
    printf "\n\n"
    echo "Inserting test data..."
    "$SCRIPT_DIR"/infrastructure/insert_test_data.sh
fi

printf "\n\n"
echo "Starting pipeline..."
"$SCRIPT_DIR"/"$TOOL"/start_pipeline.sh

if [[ "$MODE" == "cdc" ]]; then
    printf "\n\n"
    echo "Inserting test data..."
    "$SCRIPT_DIR"/infrastructure/insert_test_data.sh
fi

