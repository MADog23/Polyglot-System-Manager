# Polyglot System Manager — Architecture Overview

The Polyglot System Manager (PSM) is a multi‑language system designed to demonstrate clean separation of concerns, inter‑service communication, and real‑world engineering patterns across C++, Python, Java, Node.js, and HTML5.

## Goals
- Collect system metrics efficiently
- Orchestrate and normalize data
- Perform background analysis and alerting
- Expose a unified REST API
- Visualize metrics and alerts in a dashboard

## High‑Level Architecture
```
[C++ Agent] → raw metrics
      ↓
[Python Orchestrator] → normalized data + events
      ↓
[Java Services] → alerts + summaries
      ↓
[Node API] → REST endpoints
      ↓
[HTML5 Dashboard]
```

## Components
- **agent-cpp** — low‑level metrics collector
- **orchestrator-py** — central coordinator
- **services-java** — analysis and alerting
- **api-node** — unified REST API
- **dashboard** — visualization layer

Each component is isolated, testable, and communicates through simple JSON interfaces.