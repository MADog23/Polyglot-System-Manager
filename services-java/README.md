# Java Background Services

The Java Services perform long‑running analysis and alerting for the Polyglot System Manager (PSM).  
They consume normalized snapshots from the Python orchestrator and produce alerts and summaries.

This service can be started individually (see instructions below) or launched automatically using the global start script located in /scripts.

## Responsibilities
- Trend analysis
- Threshold‑based alerting
- Rolling summaries
- Scheduled tasks

## Structure
```
services-java/
├─ src/main/java/psm/
├─ pom.xml
└─ README.md
```

## Build
```
mvn clean package
```

## Run
```
mvn spring-boot:run
```

## Endpoints
- `POST /internal/snapshots`
- `GET /internal/alerts`
- `GET /internal/summary`
