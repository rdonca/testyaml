param (
    [string]$filePath,
    [string]$serverName,
    [string]$appName,
    [string]$variableName
)

# Read the JSON file
$json = Get-Content $filePath | ConvertFrom-Json

# Initialize flags
$serverFound = $false
$appFound = $false
$appVersion = $null

# Iterate through the servers array
foreach ($server in $json.servers) {
    if ($server.PSObject.Properties.Name -contains $serverName) {
        $serverFound = $true
        $apps = $server.$serverName.apps
        if ($apps -contains $appName) {
            $appFound = $true
            $appVersion = $server.$serverName.version
            break
        }
    }
}

if (-not $serverFound) {
    Write-Output "Server '$serverName' not found."
    exit 1
}

if (-not $appFound) {
    Write-Output "Application '$appName' not found on server '$serverName'."
    exit 1
}

# Set the output for GitHub Actions
Write-Output "::set-output name=$variableName::$appVersion"