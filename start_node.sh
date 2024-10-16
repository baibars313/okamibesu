#!/bin/bash
# ps aux | grep besu
# Function to start the specified node
start_node() {
    NODE_NAME=$1
    ENODE_URL=$2

    if [ "$NODE_NAME" == "node1" ]; then
        COMMAND="/usr/local/bin/besu/bin/besu --data-path=okami/Node-1/data \
          --genesis-file=okami/cliqueGenesis.json \
          --network-id 147 \
          --rpc-http-enabled \
          --rpc-http-api=ETH,NET,CLIQUE \
          --rpc-http-host=0.0.0.0 \
          --host-allowlist='*' \
          --rpc-http-cors-origins='all' \
          --profile=ENTERPRISE"

        echo "Starting Node 1..."
        eval "$COMMAND >> node1.log 2>&1 &"

    elif [ "$NODE_NAME" == "node2" ]; then
        if [ -z "$ENODE_URL" ]; then
            echo "Enode URL is required for Node 2."
            exit 1
        fi

        COMMAND="/usr/local/bin/besu/bin/besu --data-path=okami/Node-2/data \
          --genesis-file=okami/cliqueGenesis.json \
          --bootnodes=$ENODE_URL \
          --network-id 147 \
          --p2p-port=30304 \
          --rpc-http-enabled \
          --rpc-http-api=ETH,NET,CLIQUE \
          --rpc-http-host=0.0.0.0 \
          --host-allowlist='*' \
          --rpc-http-cors-origins='all' \
          --rpc-http-port=8546 \
          --profile=ENTERPRISE"

        echo "Starting Node 2 with bootnodes $ENODE_URL..."
        eval "$COMMAND >> node2.log 2>&1 &"

    elif [ "$NODE_NAME" == "node3" ]; then
        if [ -z "$ENODE_URL" ]; then
            echo "Enode URL is required for Node 3."
            exit 1
        fi

        COMMAND="/usr/local/bin/besu/bin/besu --data-path=okami/Node-3/data \
          --genesis-file=okami/cliqueGenesis.json \
          --bootnodes=$ENODE_URL \
          --network-id 147 \
          --p2p-port=30305 \
          --rpc-http-enabled \
          --rpc-http-api=ETH,NET,CLIQUE \
          --rpc-http-host=0.0.0.0 \
          --host-allowlist='*' \
          --rpc-http-cors-origins='all' \
          --rpc-http-port=8547 \
          --profile=ENTERPRISE"

        echo "Starting Node 3 with bootnodes $ENODE_URL..."
        eval "$COMMAND >> node3.log 2>&1 &"

    elif [ "$NODE_NAME" == "show-genesis" ]; then
        COMMAND="cat okami/cliqueGenesis.json"
        echo "Showing genesis file..."
        eval "$COMMAND"

    else
        echo "Invalid node name. Please specify node1, node2, node3, or show-genesis."
        exit 1
    fi
}

# Check if a node name was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <node1|node2|node3|show-genesis> [enode_url]"
    exit 1
fi

# Start the specified node with the enode URL if provided
start_node "$1" "$2"
