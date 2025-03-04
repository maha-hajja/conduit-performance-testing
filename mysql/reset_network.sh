#!/bin/bash

set -eou pipefail

echo "Recreating network..."


# Check if the network "benchi" exists
if docker network ls | grep "benchi"; then
    echo "Deleting existing network 'benchi'..."
    docker network rm benchi
else
    echo "Network 'benchi' does not exist."
fi

# Create the network again with the bridge driver
echo "Creating network 'benchi' with bridge driver..."
docker network create --driver bridge benchi

echo "Network 'benchi' recreated successfully with bridge driver."
