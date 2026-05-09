# Detailed Architecture Plan — Polyglot System Manager (PSM)

## 1. System goals

- **Primary goal:** Provide a polyglot, layered system that monitors host metrics, processes them, exposes them via an API, and visualizes them in a browser.
- **Secondary goal:** Clearly demonstrate:
  - C++ for low-level metrics
  - Python for orchestration
  - Java for background processing
  - Node.js for REST API
  - HTML5/JS for dashboard

Non-goals:
- Not a full-blown production monitoring stack.
- No hard dependency on external observability platforms.

---

## 2. High-level architecture

```text
[C++ Metrics Agent]
        ↓ raw metrics (JSON over TCP/Unix socket)
[Python Orchestrator]
        ↓ normalized events / data (HTTP/JSON or message queue)
[Java Background Services]
        ↓ processed insights / alerts (HTTP/JSON)
[Node.js REST API]
        ↓ HTTP/JSON
[HTML5 Dashboard]
```

Communication patterns:
- **C++ → Python:** Request/response over TCP or Unix socket.
- **Python → Java:** HTTP/JSON (internal API) or simple message queue abstraction.
- **Node.js → Python/Java:** HTTP/JSON.
- **Dashboard → Node.js:** HTTP/JSON (optional WebSocket later).

---

## 3. Repository layout

```text
polyglot-system-manager/
│
├─ metrics-agent-cpp/
│  ├─ src/
│  ├─ include/
│  ├─ CMakeLists.txt
│  └─ README.md
│
├─ orchestrator-python/
│  ├─ psm/
│  ├─ requirements.txt
│  └─ README.md
│
├─ background-services-java/
│  ├─ src/main/java/com/psm/
│  ├─ pom.xml
│  └─ README.md
│
├─ api-nodejs/
│  ├─ src/
│  ├─ package.json
│  └─ README.md
│
├─ dashboard-html5/
│  ├─ index.html
│  ├─ js/
│  ├─ css/
│  └─ README.md
│
├─ docker/
│  ├─ cpp.Dockerfile
│  ├─ python.Dockerfile
│  ├─ java.Dockerfile
│  ├─ node.Dockerfile
│  └─ docker-compose.yml
│
└─ docs/
   ├─ architecture-overview.md
   ├─ detailed-architecture-plan.md   ← this file
   ├─ data-flow.md
   ├─ api-contracts.md
   └─ install-run-guide.md
```

---

## 4. Component designs

### 4.1 C++ Metrics Agent

**Responsibility:** Collect host metrics and expose them via a simple JSON protocol.

#### 4.1.1 Core types

```cpp
struct SystemMetrics {
    double cpu_usage_percent;
    double memory_used_mb;
    double memory_total_mb;
    double disk_read_mb_s;
    double disk_write_mb_s;
    double net_in_kb_s;
    double net_out_kb_s;
};

struct ProcessInfo {
    int pid;
    std::string name;
    double cpu_percent;
    double memory_mb;
};

struct Snapshot {
    std::time_t timestamp;
    SystemMetrics system;
    std::vector<ProcessInfo> processes;
};
```

#### 4.1.2 Main classes

- **MetricsCollector**
  - `SystemMetrics collect_system_metrics();`
  - `std::vector<ProcessInfo> collect_process_metrics();`

- **JsonSerializer**
  - `std::string serialize(const Snapshot& snapshot);`

- **IPCServer**
  - Listens on configurable port/socket.
  - On `"GET_METRICS"`:
    - Collects metrics via `MetricsCollector`.
    - Wraps into `Snapshot`.
    - Serializes to JSON.
    - Sends response.

- **main.cpp**
  - Parses CLI args: `--port`, `--interval`, `--socket-path`.
  - Starts `IPCServer`.

#### 4.1.3 Protocol

- Request (plain text):
  ```text
  GET_METRICS\n
  ```

- Response (JSON):
  ```json
  {
    "timestamp": 1736451234,
    "system": {
      "cpu_usage_percent": 37.5,
      "memory_used_mb": 4096,
      "memory_total_mb": 8192,
      "disk_read_mb_s": 1.2,
      "disk_write_mb_s": 0.4,
      "net_in_kb_s": 120.5,
      "net_out_kb_s": 80.3
    },
    "processes": [
      { "pid": 1234, "name": "chrome", "cpu_percent": 12.3, "memory_mb": 512.0 }
    ]
  }
  ```

---

### 4.2 Python Orchestrator

**Responsibility:** Central coordinator; polls C++ agent, normalizes data, stores history, and forwards to Java.

#### 4.2.1 Modules

- `psm/config.py`
  - Agent host/port, polling interval, history window, Java service URL.

- `psm/models.py`
  - Python equivalents of `SystemMetrics`, `ProcessInfo`, `Snapshot` using `dataclasses`.

- `psm/agent_client.py`
  - Opens TCP/Unix socket to C++ agent.
  - Sends `"GET_METRICS"`.
  - Parses JSON into `Snapshot`.

- `psm/storage.py`
  - In-memory ring buffer of snapshots.
  - Methods:
    - `add_snapshot(snapshot)`
    - `get_latest()`
    - `get_history(window_sec)`

- `psm/scheduler.py`
  - Periodic polling loop:
    - Calls `AgentClient.get_snapshot()`.
    - Stores in `storage`.
    - Optionally posts to Java service.

- `psm/java_client.py`
  - HTTP client to Java background services.
  - Methods:
    - `send_snapshot(snapshot)`
    - `get_alerts()`

- `psm/service.py`
  - Thin wrapper exposing orchestrator state to Node.js (if needed via internal HTTP or shared store).

- `main.py`
  - Wires config, storage, agent client, scheduler, Java client.
  - Starts polling loop.

#### 4.2.2 Internal data model (Python)

```python
from dataclasses import dataclass
from typing import List

@dataclass
class SystemMetrics:
    timestamp: float
    cpu_usage_percent: float
    memory_used_mb: float
    memory_total_mb: float
    disk_read_mb_s: float
    disk_write_mb_s: float
    net_in_kb_s: float
    net_out_kb_s: float

@dataclass
class ProcessInfo:
    pid: int
    name: str
    cpu_percent: float
    memory_mb: float

@dataclass
class Snapshot:
    system: SystemMetrics
    processes: List[ProcessInfo]
```

---

### 4.3 Java Background Services

**Responsibility:** Long-running analysis, alerts, and higher-level insights.

#### 4.3.1 Technology

- Spring Boot (or minimal Java HTTP framework).
- Exposes REST endpoints for:
  - Receiving snapshots.
  - Serving alerts and analysis.

#### 4.3.2 Endpoints

- `POST /internal/snapshots`
  - Body: snapshot JSON (same schema as Python normalized snapshot).
  - Action: store, analyze, update alerts.

- `GET /internal/alerts`
  - Returns current alerts.

- `GET /internal/summary`
  - Returns aggregated metrics (e.g., averages over last N minutes).

#### 4.3.3 Core services

- **SnapshotService**
  - Stores recent snapshots (in-memory or simple DB).
  - Provides access for analysis.

- **AlertService**
  - Rules:
    - High CPU threshold.
    - High memory usage.
    - Sustained load over time.
  - Produces alert objects:
    ```json
    {
      "id": "alert-1",
      "type": "CPU_HIGH",
      "severity": "warning",
      "message": "CPU usage above 80% for 60s",
      "timestamp": 1736451234
    }
    ```

- **SummaryService**
  - Computes rolling averages, min/max, etc.

---

### 4.4 Node.js REST API

**Responsibility:** Public API for dashboard and external clients.

#### 4.4.1 Technology

- Node.js + Express (or similar).
- Communicates with:
  - Python orchestrator (for metrics).
  - Java services (for alerts/summary).

#### 4.4.2 Endpoints

- `GET /metrics/latest`
  - Calls Python (or shared store) to fetch latest snapshot.
  - Returns snapshot JSON.

- `GET /metrics/history?window=60`
  - Calls Python to fetch history for last `window` seconds.

- `GET /alerts`
  - Calls Java `/internal/alerts`.

- `GET /system/summary`
  - Calls Java `/internal/summary`.

#### 4.4.3 Internal clients

- `pythonClient.js`
  - Base URL: `http://orchestrator-python:PORT` (or localhost).
  - Methods:
    - `getLatestSnapshot()`
    - `getHistory(windowSec)`

- `javaClient.js`
  - Base URL: `http://background-services-java:PORT`.
  - Methods:
    - `getAlerts()`
    - `getSummary()`

---

### 4.5 HTML5 Dashboard

**Responsibility:** Visual, interactive UI.

#### 4.5.1 Layout

- **Header:** Title + status indicator.
- **Section 1:** CPU & memory gauges.
- **Section 2:** Time-series charts for CPU, memory, disk, network.
- **Section 3:** Top processes table.
- **Section 4:** Alerts list.

#### 4.5.2 Data sources

- `GET /metrics/latest`
- `GET /metrics/history?window=...`
- `GET /alerts`

#### 4.5.3 JS modules

- `js/api_client.js`
  - `fetchLatestMetrics()`
  - `fetchHistory(windowSec)`
  - `fetchAlerts()`

- `js/charts.js`
  - Initialize and update charts (e.g., Chart.js).

- `js/ui.js`
  - DOM updates for gauges, tables, alerts.

- `js/main.js`
  - Orchestrates periodic refresh:
    - On load: fetch latest + history + alerts.
    - `setInterval` for periodic updates.

---

## 5. Data contracts

### 5.1 Snapshot (C++ → Python → Java → Node → Dashboard)

```json
{
  "timestamp": 1736451234.123,
  "system": {
    "cpu_usage_percent": 37.5,
    "memory_used_mb": 4096,
    "memory_total_mb": 8192,
    "disk_read_mb_s": 1.2,
    "disk_write_mb_s": 0.4,
    "net_in_kb_s": 120.5,
    "net_out_kb_s": 80.3
  },
  "processes": [
    { "pid": 1234, "name": "chrome", "cpu_percent": 12.3, "memory_mb": 512.0 }
  ]
}
```

### 5.2 Alert (Java → Node → Dashboard)

```json
{
  "id": "alert-1",
  "type": "CPU_HIGH",
  "severity": "warning",
  "message": "CPU usage above 80% for 60s",
  "timestamp": 1736451234
}
```

---

## 6. Deployment & runtime topology

### 6.1 Local (non-Docker)

- C++ agent: local process on host.
- Python orchestrator: local process, connects to C++ via TCP/Unix socket.
- Java services: local process, HTTP server on port (e.g., 8081).
- Node.js API: local process, HTTP server on port (e.g., 3000).
- Dashboard: static files served locally or via simple HTTP server.

### 6.2 Docker (optional)

- Each component in its own container.
- `docker-compose.yml` defines:
  - `cpp-agent`
  - `python-orchestrator`
  - `java-services`
  - `node-api`
  - `dashboard` (optional static server)

Networking:
- Internal Docker network.
- Services address each other by container name.

---

## 7. Cross-cutting concerns

### 7.1 Logging

- C++: stdout/stderr with log levels.
- Python: `logging` module, structured logs where useful.
- Java: SLF4J/Logback.
- Node.js: simple console logging or a lightweight logger.

### 7.2 Error handling

- C++ agent:
  - Graceful handling of metric collection failures.
  - Returns error JSON or appropriate status.
- Python:
  - Retries on C++ connection failure.
  - Skips failed polls, logs errors.
- Java:
  - Validates incoming snapshots.
  - Handles malformed data gracefully.
- Node.js:
  - Returns clear HTTP error codes and messages.

### 7.3 Configuration

- Environment variables for:
  - Ports
  - Hostnames
  - Polling intervals
  - Thresholds (for alerts)

---

## 8. Implementation order

1. **C++ Metrics Agent**
   - Implement metrics collection and JSON response.
2. **Python Orchestrator**
   - Implement agent client, storage, scheduler.
3. **Java Background Services**
   - Implement snapshot ingestion and basic alerting.
4. **Node.js REST API**
   - Implement endpoints and internal clients.
5. **HTML5 Dashboard**
   - Implement basic UI and wire to API.
6. **Docker & docs**
   - Add docker-compose and finalize documentation.