# Setup & Run Guide — Polyglot System Manager

This guide explains how to install and run all components of the PSM.

---

# Requirements
- C++ compiler (GCC/Clang/MSVC)
- Python 3.10+
- Java 17+
- Node.js 18+
- (Optional) Docker & Docker Compose

---

# 1. Build the C++ Agent
```
cd agent-cpp
mkdir build && cd build
cmake ..
make
./agent
```

---

# 2. Start the Python Orchestrator
```
cd orchestrator-py
pip install -r requirements.txt
python main.py
```

---

# 3. Start the Java Services
```
cd services-java
mvn spring-boot:run
```

---

# 4. Start the Node API
```
cd api-node
npm install
npm start
```

---

# 5. Open the Dashboard
Open:
```
dashboard/index.html
```

Or serve with any static file server.

---

# Optional: Docker Compose
```
cd docker
docker compose up
```

This launches all services together.

---

# Notes
- Components can run independently during development
- Environment variables control ports and hostnames
- Logs are printed to stdout for simplicity