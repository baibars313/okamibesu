#!/bin/bash

# Create the root directory "okami" and subdirectories for each node
mkdir -p okami/Node-1/data okami/Node-2/data okami/Node-3/data

# Change to Node-1 directory and export the node address
cd okami/Node-1/ || { echo "Failed to change directory to okami/Node-1"; exit 1; }
besu --data-path=data public-key export-address --to=data/node1Address

# Check if the address file was created successfully
if [ ! -f data/node1Address ]; then
    echo "Failed to create node1Address file. Please check Besu command."
    exit 1
fi

# Go back to the root directory
cd ../..

# Copy the genesis file to the okami directory
cp cliqueGenesis.json okami/cliqueGenesis.json

# Retrieve the node address and remove the '0x' prefix
NODE_ADDRESS=$(cat okami/Node-1/data/node1Address | sed 's/^0x//')

# Check if the address was retrieved successfully
if [ -z "$NODE_ADDRESS" ]; then
    echo "Node address is empty. Please check the node1Address file."
    exit 1
fi

# Use sed to replace the placeholder with the actual node address (without '0x')
sed -i "s/node_address/$NODE_ADDRESS/g" okami/cliqueGenesis.json

echo "Genesis file updated successfully with the node address (without '0x')."
