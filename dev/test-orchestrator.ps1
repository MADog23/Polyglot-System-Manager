Write-Host "Testing orchestrator (placeholder)..."

try {
    $response = Invoke-WebRequest -Uri "http://localhost:5000/health" -UseBasicParsing
    Write-Host "Response:"
    Write-Host $response.Content
}
catch {
    Write-Host "Error contacting orchestrator:" $_
}
