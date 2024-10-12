# Use Besu image as the base
FROM hyperledger/besu:latest

# Set the working directory
WORKDIR /app

# Copy necessary files
COPY cliqueGenesis.json /app/cliqueGenesis.json
COPY setup.sh /app/setup.sh
COPY start_node.sh /app/start_node.sh

# Make scripts executable
RUN chmod +x /app/setup.sh /app/start_node.sh

# Run the setup script
RUN /app/setup.sh

# Start the Besu node (Node-1 as default)
CMD ["/app/start_node.sh", "node1"]
