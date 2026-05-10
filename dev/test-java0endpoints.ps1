Write-Host "Testing Java alerts endpoint..."
try {
    $alerts = Invoke-WebRequest -Uri "http://localhost:8081/internal/alerts" -UseBasicParsing
    Write-Host $alerts.Content
}
catch {
    Write-Host "Error hitting alerts endpoint:" $_
}

Write-Host "`nTesting Java summary endpoint..."
try {
    $summary = Invoke-WebRequest -Uri "http://localhost:8081/internal/summary" -UseBasicParsing
    Write-Host $summary.Content
}
catch {
    Write-Host "Error hitting summary endpoint:" $_
}
