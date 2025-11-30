param(
    [string]$MatlabPath
)

$ErrorActionPreference = 'Stop'

# Resolve project root from this script's location
$root = Split-Path -Parent $PSScriptRoot
$rootForMatlab = $root -replace "\\", "/"

# Find matlab.exe if not provided
if (-not $MatlabPath) {
    $cmd = Get-Command matlab -ErrorAction SilentlyContinue
    if ($cmd) {
        $MatlabPath = $cmd.Source
    }
    else {
        $candidates = @(
            "C:\\Program Files\\MATLAB\\R2025b\\bin\\matlab.exe",
            "C:\\Program Files\\MATLAB\\R2024b\\bin\\matlab.exe",
            "C:\\Program Files\\MATLAB\\R2024a\\bin\\matlab.exe",
            "C:\\Program Files\\MATLAB\\R2023b\\bin\\matlab.exe"
        )
        $MatlabPath = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1
    }
}

if (-not $MatlabPath -or -not (Test-Path $MatlabPath)) {
    Write-Error "Could not find matlab.exe. Install MATLAB or pass -MatlabPath 'C:\\Path\\To\\matlab.exe'"
    exit 1
}

# Build MATLAB batch command using the path-agnostic runner
$matlabCode = "try; run(fullfile('$rootForMatlab','run_compare.m')); catch ME; disp(getReport(ME)); exit(1); end"

& $MatlabPath -batch $matlabCode
