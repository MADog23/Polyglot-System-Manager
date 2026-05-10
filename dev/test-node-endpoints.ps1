Write-Host "Testing Node API /metrics/latest..."
try {
    $latest = Invoke-WebRequest -Uri "http://localhost:3000/metrics/latest" -UseBasicParsing
    Write-Host $latest.Content
}
catch {
    Write-Host "Error hitting /metrics/latest:" $_
}

Write-Host "`nTesting Node API /alerts..."
try {
    $alerts = Invoke-WebRequest -Uri "http://localhost:3000/alerts" -UseBasicParsing
    Write-Host $alerts.Content
}
catch {
    Write-Host "Error hitting /alerts:" $_
}

Write-Host "`nTesting Node API /system/summary..."
try {
    $summary = Invoke-WebRequest -Uri "http://localhost:3000/system/summary" -UseBasicParsing
    Write-Host $summary.Content
}
catch {
    Write-Host "Error hitting /system/summary:" $_
}
