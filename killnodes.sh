#!/bin/bash

# Function to stop Besu services
stop_besu_services() {
    echo "Stopping Besu services..."

    # Get the PID of the Besu process
    besu_pid=$(pgrep -f besu)

    if [ -z "$besu_pid" ]; then
        echo "No Besu service is running."
    else
        echo "Stopping Besu process with PID: $besu_pid"
        kill -TERM "$besu_pid"  # Send a TERM signal to gracefully stop the process
        sleep 2  # Wait for 2 seconds to allow the process to terminate

        # Check if the process has terminated
        if ps -p "$besu_pid" > /dev/null; then
            echo "Besu process did not terminate. Forcing termination..."
            kill -KILL "$besu_pid"  # Forcefully kill the process if it hasn't terminated
        else
            echo "Besu process stopped successfully."
        fi
    fi
}

# Function to remove log files
remove_log_files() {
    echo "Removing log files..."

    # Change this path to the directory where your log files are stored
    log_directory="logs"

    # Check if the log directory exists
        rm -f *.log && rm -rf *.jfr
        echo "All log files removed from $log_directory."
  
}

# Stop Besu services
stop_besu_services

# Remove log files
remove_log_files

echo "All services stopped and log files removed."
