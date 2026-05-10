# Data Flow — Polyglot System Manager

This document describes how data moves through the PSM from raw system metrics to the final dashboard visualization.

## 1. C++ Agent → Python Orchestrator
- Python connects via TCP or Unix socket
- Sends: `GET_METRICS`
- C++ responds with a JSON snapshot:
  - CPU usage
  - Memory usage
  - Disk I/O
  - Network I/O
  - Process list

## 2. Python Orchestrator → Java Services
- Python normalizes the snapshot
- Sends JSON to Java:
  - `/internal/snapshots`
- Java stores and analyzes the data

## 3. Java Services → Node API
- Node fetches:
  - Alerts: `/internal/alerts`
  - Summaries: `/internal/summary`

## 4. Python Orchestrator → Node API
- Node fetches:
  - Latest metrics
  - History window

## 5. Node API → Dashboard
- Dashboard polls:
  - `/metrics/latest`
  - `/metrics/history`
  - `/alerts`

Optional:
- WebSocket live updates (future enhancement)

## Summary
The flow is intentionally linear and easy to reason about, making the system ideal for demonstration and extension.