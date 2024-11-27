$pcName = $env:COMPUTERNAME
$currentDirectory = Get-Location
$storageDirectory = "$currentDirectory\$pcName\DXdiag"
$filePath = "$storageDirectory\dxdiag.txt"

try {
    if (-not (Test-Path $storageDirectory)) {
        New-Item -Path $storageDirectory -ItemType Directory -Force
    }

    $dxdiagPath = "$env:SystemRoot\System32\dxdiag.exe"
    
    if (Test-Path $dxdiagPath) {
        Start-Process -NoNewWindow -FilePath $dxdiagPath -ArgumentList "/t $filePath" -Wait
        
        if (Test-Path $filePath) {
            Write-Host "The dxdiag file was successfully created at: $filePath"
        } else {
            Write-Host "An error occurred: The dxdiag file was not created."
        }
    } else {
        Write-Host "Error: dxdiag program not found at the expected location: $dxdiagPath"
    }
} catch {
    Write-Host "An error occurred: $_"
}
