#!/bin/bash

set -eou pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

"$SCRIPT_DIR"/stop_infra.sh

printf "\n\n"
"$SCRIPT_DIR"/clean_up.sh

printf "\n\n"
"$SCRIPT_DIR"/reset_network.sh

printf "\n\n"
"$SCRIPT_DIR"/start_infra.sh
