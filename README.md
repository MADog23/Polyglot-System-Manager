# **Polyglot System Manager (PSM)**  
*A multi-language system monitoring and analytics platform demonstrating C++, Python, Java, Node.js, and HTML5 working together in a clean, modern architecture.*

---

## **📌 Overview**

The **Polyglot System Manager (PSM)** is a fully modular, multi-language system designed to showcase real-world engineering skills across:

- **Systems programming** (C++)
- **Orchestration & data processing** (Python)
- **Background computation & enterprise patterns** (Java)
- **API design & service exposure** (Node.js)
- **Frontend visualization & UX** (HTML5/JS)

The PSM collects system metrics, processes them through multiple services, exposes them via a REST API, and visualizes them in a browser dashboard.

This project is intentionally structured to be **easy to read, easy to install, and easy to deploy**, making it ideal for engineering portfolios and technical demonstrations.

---

## **🎯 Purpose**

The PSM demonstrates:

- Clean **separation of concerns** across languages  
- Real-world **inter-service communication**  
- A layered, maintainable **polyglot architecture**  
- Practical system monitoring and analytics  
- A professional, production-style repository layout  

Each component has a **single, well-defined responsibility**, making the system easy to understand at a glance.

---

## Quick Start
To launch the entire system at once:

Linux/macOS:
    ./scripts/start.sh

Windows:
    ./scripts/start.ps1

---

## **🧩 Architecture**

```
[C++ Metrics Agent]
        ↓ raw metrics (JSON)
[Python Orchestrator]
        ↓ normalized events / data
[Java Background Services]
        ↓ processed insights / alerts
[Node.js REST API]
        ↓ HTTP/JSON
[HTML5 Dashboard]
```

---

## **📁 Repository Structure**

```
polyglot-system-manager/
│
├─ metrics-agent-cpp/            # C++ system metrics collector
│
├─ orchestrator-python/          # Python orchestrator
│
├─ background-services-java/     # Java background workers
│
├─ api-nodejs/                   # Node.js REST API
│
├─ dashboard-html5/              # HTML5 dashboard
│
├─ docker/                       # Optional: unified deployment
│
└─ docs/                         # Architecture, API contracts, diagrams
```

Each directory includes its own README with build/run instructions.

---

## **🧠 Component Responsibilities**

### **1. C++ Metrics Agent**
Collects low-level system metrics with high performance.

Outputs include:
- CPU usage  
- Memory usage  
- Disk I/O  
- Network I/O  
- Process list  

Exposes metrics via a simple JSON protocol over TCP or Unix socket.

---

### **2. Python Orchestrator**
Acts as the “brain” of the system.

Responsibilities:
- Poll the C++ agent  
- Normalize raw metrics  
- Maintain rolling history  
- Forward events to Java services  
- Provide internal data to the Node.js API  

---

### **3. Java Background Services**
Performs heavy computation and long-running tasks.

Responsibilities:
- Trend analysis  
- Threshold-based alerting  
- Scheduled reports  
- Long-running asynchronous tasks  

Consumes normalized events from Python and produces insights/alerts.

---

### **4. Node.js REST API**
Public-facing API layer for the dashboard and external clients.

Endpoints include:
- `/metrics/latest`  
- `/metrics/history`  
- `/alerts`  
- `/system/status`  

Aggregates data from Python and Java services.

---

### **5. HTML5 Dashboard**
A clean, interactive dashboard for visualizing system data.

Displays:
- CPU/memory gauges  
- Disk/network charts  
- Top processes  
- Alerts  
- Historical graphs  

Consumes the Node.js REST API.

---

## **🚀 Installation & Run Guide**

### **Prerequisites**
- C++ compiler (GCC/Clang/MSVC)
- Python 3.10+
- Java 17+
- Node.js 18+
- (Optional) Docker & Docker Compose

---

### **1. Build the C++ Metrics Agent**
```
cd metrics-agent-cpp
mkdir build && cd build
cmake ..
make
./metrics-agent
```

---

### **2. Start the Python Orchestrator**
```
cd orchestrator-python
pip install -r requirements.txt
python main.py
```

---

### **3. Start the Java Background Services**
```
cd background-services-java
mvn spring-boot:run
```

---

### **4. Start the Node.js REST API**
```
cd api-nodejs
npm install
npm start
```

---

### **5. Open the HTML5 Dashboard**
Open:

```
dashboard-html5/index.html
```

Or serve it with any static file server.

---

## **🐳 Optional: One-Command Deployment**
If using Docker:

```
cd docker
docker compose up
```

This launches all services together.

---

## **📚 Documentation**

See the `docs/` directory for:

- **architecture-overview.md**  
- **data-flow.md**  
- **api-contracts.md**  
- **install-run-guide.md**  

---

## **📌 Status**
This project is actively being built.  
Future enhancements include:

- Per-core CPU metrics  
- Dark mode dashboard  
- WebSocket live updates  
- Plugin system for additional metrics  

---

## **📄 License**
MIT License (or your preferred license).
