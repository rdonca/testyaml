function Get-InsightVersion {
    # Go up one level from the current directory
    $versionFilePath = Join-Path -Path (Split-Path -Parent $PSScriptRoot) -ChildPath "version.txt"
    
    if (-not (Test-Path -Path $versionFilePath)) {
        Write-Error "Version file not found at $versionFilePath"
        return $null
    }
    
    $version = Get-Content -Path $versionFilePath -Raw
    
    return $version.Trim()
}

$result = Get-InsightVersion
if ($result) {
    Write-Output $result
}