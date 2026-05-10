# Python Orchestrator

The Python Orchestrator is the central coordinator of the Polyglot System Manager (PSM).  
It polls the C++ agent, normalizes metrics, stores history, and forwards data to the Java services.

Note: The orchestrator does not automatically launch other components. 
Use the /scripts/start.sh or start.ps1 script to start the full system.


## Responsibilities
- Poll C++ metrics agent
- Normalize raw metrics
- Maintain rolling history
- Forward snapshots to Java services
- Provide data to the Node.js API

## Structure
```
orchestrator-py/
├─ psm/
│  ├─ config.py
│  ├─ agent.py
│  ├─ storage.py
│  ├─ scheduler.py
│  ├─ java_client.py
│  └─ models.py
├─ requirements.txt
└─ README.md
```

## Install
```
pip install -r requirements.txt
```

## Run
```
python main.py
```

## Notes
The orchestrator is intentionally lightweight and easy to extend.