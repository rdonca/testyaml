param (
    [string]$filePath,
    [string]$serverName,
    [string]$variableName
)

# Read the JSON file
$json = Get-Content $filePath | ConvertFrom-Json

# Initialize flag
$serverFound = $false

# Iterate through the servers array
foreach ($server in $json.servers) {
    if ($server.PSObject.Properties.Name -contains $serverName) {
        $serverFound = $true
        $version = $server.$serverName.version
        Write-Output "Server '$serverName' version is '$version'."
        # Set the output for GitHub Actions
        Write-Output "::set-output name=$variableName::$version"
        exit 0
    }
}

if (-not $serverFound) {
    Write-Output "Server '$serverName' not found."
    exit 1
}