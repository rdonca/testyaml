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
$appExists = $false

# Iterate through the servers array
foreach ($server in $json.servers) {
    if ($server.PSObject.Properties.Name -contains $serverName) {
        $serverFound = $true
        $apps = $server.$serverName.apps
        if ($apps -contains $appName) {
            $appExists = $true
            break
        }
    }
}

if (-not $serverFound) {
    Write-Output "Server '$serverName' not found."
    exit 1
}

# Set the output for GitHub Actions
if ($appExists) {
    Write-Output "::set-output name=$variableName::true"
} else {
    Write-Output "::set-output name=$variableName::false"
}