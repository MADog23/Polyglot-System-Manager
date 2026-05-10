#!/bin/bash

echo "Testing Node API /metrics/latest..."
curl http://localhost:3000/metrics/latest

echo ""
echo "Testing Node API /alerts..."
curl http://localhost:3000/alerts

echo ""
echo "Testing Node API /system/summary..."
curl http://localhost:3000/system/summary
