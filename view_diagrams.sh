#!/bin/bash

# Simple script to view the diagrams in a browser

set -e

PYTHON_CMD="python3"
if ! command -v python3 &> /dev/null; then
    PYTHON_CMD="python"
fi

echo "Starting a local web server to view diagrams..."
echo "View diagrams at: http://localhost:8000/"
echo "Press Ctrl+C to stop the server when done."

# Start a simple HTTP server
$PYTHON_CMD -m http.server 8000

# This will be unreachable until the server is stopped with Ctrl+C
echo "Server stopped."