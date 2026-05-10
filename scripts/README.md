# PSM Start/Stop Scripts

This folder contains convenience scripts for starting and stopping all Polyglot System Manager components with a single action.

## Files
- `start.sh` — Start all components (Linux/macOS)
- `stop.sh` — Stop all components (Linux/macOS)
- `start.ps1` — Start all components (Windows PowerShell)
- `stop.ps1` — Stop all components (Windows PowerShell)

## Usage (Linux/macOS)
```
chmod +x start.sh stop.sh
./start.sh
./stop.sh
```

## Usage (Windows PowerShell)
```
.\start.ps1
.\stop.ps1
```

## What These Scripts Do
- Launch the C++ agent
- Launch the Python orchestrator
- Launch the Java background services
- Launch the Node.js REST API
- Open the HTML5 dashboard
- Provide a single command to stop all processes

These scripts are intended for development and demonstration.