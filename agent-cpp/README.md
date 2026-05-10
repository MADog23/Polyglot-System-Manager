# C++ Metrics Agent

The C++ Metrics Agent is the low‑level system collector for the Polyglot System Manager (PSM).  
It gathers raw host metrics with high performance and exposes them through a simple JSON protocol.

This service can be started individually (see instructions below) or launched automatically using the global start script located in /scripts.

## Features
- CPU usage
- Memory usage
- Disk I/O
- Network I/O
- Process list
- Lightweight JSON output
- TCP or Unix socket interface

## Structure
```
agent-cpp/
├─ src/
├─ include/
└─ CMakeLists.txt
```

## Build
```
mkdir build && cd build
cmake ..
make
```

## Run
```
./agent
```

## Output Format
The agent responds to `GET_METRICS` with a JSON snapshot containing system and process metrics.