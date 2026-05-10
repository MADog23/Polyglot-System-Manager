Write-Host "Sending GET_METRICS to C++ agent..."

try {
    $client = New-Object System.Net.Sockets.TcpClient("localhost", 9000)
    $stream = $client.GetStream()

    $writer = New-Object System.IO.StreamWriter($stream)
    $writer.WriteLine("GET_METRICS")
    $writer.Flush()

    $reader = New-Object System.IO.StreamReader($stream)
    $response = $reader.ReadToEnd()

    Write-Host "Response from agent:"
    Write-Host $response

    $reader.Close()
    $writer.Close()
    $client.Close()
}
catch {
    Write-Host "Error connecting to C++ agent:" $_
}
