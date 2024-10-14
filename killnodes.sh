#!/bin/bash

# Function to stop Besu services
stop_besu_services() {
    echo "Stopping Besu services..."

    # Get the PIDs of the Besu processes
    besu_pids=$(pgrep -f besu)

    if [ -z "$besu_pids" ]; then
        echo "No Besu service is running."
    else
        # Iterate over each PID and stop the process
        for pid in $besu_pids; do
            echo "Stopping Besu process with PID: $pid"
            kill -TERM "$pid"  # Send a TERM signal to gracefully stop the process
            sleep 2  # Wait for 2 seconds to allow the process to terminate

            # Check if the process has terminated
            if ps -p "$pid" > /dev/null; then
                echo "Besu process with PID $pid did not terminate. Forcing termination..."
                kill -KILL "$pid"  # Forcefully kill the process if it hasn't terminated
            else
                echo "Besu process with PID $pid stopped successfully."
            fi
        done
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
