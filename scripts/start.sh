#!/bin/bash

echo "Starting Polyglot System Manager..."

# Start C++ Agent
echo "Starting C++ Agent..."
( cd ../agent-cpp/build && ./agent ) &

# Start Python Orchestrator
echo "Starting Python Orchestrator..."
( cd ../orchestrator-py && python3 main.py ) &

# Start Java Services
echo "Starting Java Services..."
( cd ../services-java && mvn spring-boot:run ) &

# Start Node API
echo "Starting Node API..."
( cd ../api-node && node src/server.js ) &

# Open Dashboard
echo "Opening Dashboard..."
if command -v xdg-open >/dev/null; then
    xdg-open ../dashboard/index.html
elif command -v open >/dev/null; then
    open ../dashboard/index.html
fi

echo "All components started."
