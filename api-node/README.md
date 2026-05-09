# Node.js REST API

The Node API is the public interface for the Polyglot System Manager (PSM).  
It exposes metrics, history, alerts, and system status to the HTML5 dashboard and external clients.

## Responsibilities
- Serve REST endpoints
- Fetch metrics from Python orchestrator
- Fetch alerts/summary from Java services
- Provide unified JSON responses

## Structure
```
api-node/
├─ src/
│  ├─ server.js
│  ├─ py_client.js
│  └─ java_client.js
├─ package.json
└─ README.md
```

## Install
```
npm install
```

## Run
```
npm start
```

## Endpoints
- `GET /metrics/latest`
- `GET /metrics/history`
- `GET /alerts`
- `GET /system/summary`