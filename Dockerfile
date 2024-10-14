# Use Besu image as the base
FROM hyperledger/besu:latest

# Switch to root to perform setup tasks
USER root

# Set the working directory
WORKDIR /app

# Copy necessary files
COPY cliqueGenesis.json /app/cliqueGenesis.json
COPY setup.sh /app/setup.sh
COPY start_node.sh /app/start_node.sh


# Make scripts executable
RUN chmod +x /app/setup.sh /app/start_node.sh
RUN chmod +x /app/setup.sh /app/start_node.sh

# # Update the package list and install curl
# RUN apt-get update && apt-get install -y curl

# Run the setup script as root
RUN /app/setup.sh

# Switch back to the Besu default user after setup
USER besu

