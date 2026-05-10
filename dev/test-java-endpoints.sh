#!/bin/bash

echo "Testing Java alerts endpoint..."
curl http://localhost:8081/internal/alerts

echo ""
echo "Testing Java summary endpoint..."
curl http://localhost:8081/internal/summary
