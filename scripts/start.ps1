Write-Host "Starting Polyglot System Manager..."

# Start C++ Agent
Write-Host "Starting C++ Agent..."
Start-Process "..\agent-cpp\build\agent.exe"

# Start Python Orchestrator
Write-Host "Starting Python Orchestrator..."
Start-Process "python" "..\orchestrator-py\main.py"

# Start Java Services
Write-Host "Starting Java Services..."
Start-Process "mvn" "-f ..\services-java\pom.xml spring-boot:run"

# Start Node API
Write-Host "Starting Node API..."
Start-Process "node" "..\api-node\src\server.js"

# Open Dashboard
Write-Host "Opening Dashboard..."
Start-Process "..\dashboard\index.html"

Write-Host "All components started."
