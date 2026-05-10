# Development Workflow — Polyglot System Manager (PSM)

This document describes the recommended workflow for developing, running, and debugging the Polyglot System Manager.  
It is intended for contributors, reviewers, and anyone exploring the system architecture.

---

# 1. Overview

The PSM is a multi‑language system composed of five independent components:

- **agent-cpp** — C++ metrics collector  
- **orchestrator-py** — Python orchestrator  
- **services-java** — Java background analysis  
- **api-node** — Node.js REST API  
- **dashboard** — HTML5/JS visualization  

During development, each component can be run independently or all at once using the scripts in `/scripts`.

---

# 2. Starting Everything (Recommended)

For day‑to‑day development, use the **Start All** script:

### Linux/macOS
```
./scripts/start.sh
```

### Windows PowerShell
```
.\scripts\start.ps1
```

This launches:

1. C++ agent  
2. Python orchestrator  
3. Java services  
4. Node API  
5. Dashboard (opened in browser)

This is the fastest way to get the full system running.

---

# 3. Stopping Everything

To shut down all running components:

### Linux/macOS
```
./scripts/stop.sh
```

### Windows PowerShell
```
.\scripts\stop.ps1
```

This terminates all PSM‑related processes.

---

# 4. Running Components Individually

Each component can also be run on its own for debugging or development.

---

## 4.1 C++ Metrics Agent

### Build
```
cd agent-cpp
mkdir build && cd build
cmake ..
make
```

### Run
```
./agent
```

---

## 4.2 Python Orchestrator

### Install
```
cd orchestrator-py
pip install -r requirements.txt
```

### Run
```
python main.py
```

---

## 4.3 Java Services

### Run
```
cd services-java
mvn spring-boot:run
```

---

## 4.4 Node.js REST API

### Install
```
cd api-node
npm install
```

### Run
```
npm start
```

---

## 4.5 Dashboard

Open directly:

```
dashboard/index.html
```

Or serve with any static file server.

---

# 5. Debugging Workflow

## 5.1 Debugging the C++ Agent
- Add logging to `stdout`
- Use `htop`, `top`, or OS tools to verify metrics
- Test JSON output manually:
  ```
  echo "GET_METRICS" | nc localhost <port>
  ```

## 5.2 Debugging the Python Orchestrator
- Enable debug logging in `config.py`
- Use `print()` or `logging.debug()` inside:
  - `agent.py`
  - `storage.py`
  - `scheduler.py`

## 5.3 Debugging Java Services
- Use Spring Boot logs
- Hit internal endpoints directly:
  ```
  curl http://localhost:<port>/internal/alerts
  ```

## 5.4 Debugging Node API
- Use `console.log` in:
  - `py_client.js`
  - `java_client.js`
- Test endpoints:
  ```
  curl http://localhost:3000/metrics/latest
  ```

## 5.5 Debugging the Dashboard
- Use browser DevTools
- Check network requests to `/metrics/latest`, `/alerts`, etc.

---

# 6. Recommended Development Flow

1. Start everything using `/scripts/start.sh`  
2. Make changes to one component  
3. Restart only that component  
4. Refresh the dashboard  
5. Repeat  

This keeps iteration fast and isolated.

---

# 7. Optional: Docker Workflow

For containerized development:

```
cd docker
docker compose up
```

This runs all components in isolated containers.

---

# 8. Summary

The PSM is designed to be easy to run, easy to debug, and easy to extend.  
Use the **Start All** script for full-system testing and run individual components when working on specific features.