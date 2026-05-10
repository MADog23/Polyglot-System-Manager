#!/bin/bash

echo "Sending GET_METRICS to C++ agent..."
echo "GET_METRICS" | nc localhost 9000
