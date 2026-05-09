# HTML5 Dashboard

The Dashboard is the user interface for the Polyglot System Manager (PSM).  
It visualizes system metrics, alerts, and history using data from the Node.js API.

## Features
- CPU & memory gauges
- Disk & network charts
- Top processes table
- Alerts panel
- Auto‑refresh

## Structure
```
dashboard/
├─ index.html
├─ js/
│  ├─ api.js
│  ├─ charts.js
│  └─ ui.js
├─ css/
│  └─ styles.css
└─ README.md
```

## Usage
Open `index.html` in a browser or serve with any static file server.

## Data Source
The dashboard consumes JSON from the Node.js API.