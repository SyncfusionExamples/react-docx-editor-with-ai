Clear-Host

Write-Host ""
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host "           DocX AI Sample - Startup Script               " -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Cyan
Write-Host ""

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

$server = Join-Path $root "DocX.DocumentAI.Server"
$client = Join-Path $root "DocX.React.AI"

#----------------------------------------------------------
# Validate folders
#----------------------------------------------------------

if (!(Test-Path $server))
{
    Write-Host "ERROR : Server project not found." -ForegroundColor Red
    exit
}

if (!(Test-Path $client))
{
    Write-Host "ERROR : React project not found." -ForegroundColor Red
    exit
}

#----------------------------------------------------------
# Restore .NET packages
#----------------------------------------------------------

Write-Host ""
Write-Host "Restoring .NET packages..." -ForegroundColor Yellow

Push-Location $server
dotnet restore
Pop-Location

#----------------------------------------------------------
# Install React packages (only once)
#----------------------------------------------------------

if (!(Test-Path "$client\node_modules"))
{
    Write-Host ""
    Write-Host "Installing React packages..." -ForegroundColor Yellow

    Push-Location $client
    npm install
    Pop-Location
}
else
{
    Write-Host ""
    Write-Host "React packages already installed." -ForegroundColor Green
}

#----------------------------------------------------------
# Start ASP.NET Core Web API
#----------------------------------------------------------

Write-Host ""
Write-Host "Starting ASP.NET Core Web API..." -ForegroundColor Yellow

Start-Process powershell `
    -ArgumentList "-NoExit", "-Command", "cd '$server'; dotnet run"

# Give Web API time to start
Start-Sleep -Seconds 6

#----------------------------------------------------------
# Start React
#----------------------------------------------------------

Write-Host ""
Write-Host "Starting React application..." -ForegroundColor Yellow

Start-Process powershell `
    -ArgumentList "-NoExit", "-Command", "cd '$client'; npm start"

# Give React time to start
Start-Sleep -Seconds 8

#----------------------------------------------------------
# Open browser
#----------------------------------------------------------

Write-Host ""
Write-Host "Opening Swagger..." -ForegroundColor Yellow
Start-Process "http://localhost:5243/swagger"

Write-Host "Opening React application..." -ForegroundColor Yellow
Start-Process "http://localhost:3000"

Write-Host ""
Write-Host "=========================================================" -ForegroundColor Green
Write-Host "            DocX AI Sample Started Successfully          " -ForegroundColor Green
Write-Host "=========================================================" -ForegroundColor Green
Write-Host ""

Write-Host "React      : http://localhost:3000" -ForegroundColor Cyan
Write-Host "Swagger    : http://localhost:5243/swagger" -ForegroundColor Cyan
Write-Host ""