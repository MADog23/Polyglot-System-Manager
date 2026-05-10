#!/bin/bash

echo "Stopping Polyglot System Manager..."

pkill agent
pkill python3
pkill java
pkill node

echo "All components stopped."
