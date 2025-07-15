# Hotel Search Application Deployment Script for PowerShell

Write-Host "Setting up Hotel Search Application..." -ForegroundColor Green

# Create virtual environment
Write-Host "Creating virtual environment..." -ForegroundColor Yellow
python -m venv venv
& "venv\Scripts\Activate.ps1"

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Yellow
pip install -r requirements.txt

# Check environment variables
Write-Host "Checking environment configuration..." -ForegroundColor Yellow
if (!(Test-Path ".env")) {
    Write-Host "Warning: .env file not found. Please create it with your Azure Search credentials." -ForegroundColor Red
    Write-Host "Required variables:" -ForegroundColor Yellow
    Write-Host "SEARCH_SERVICE_ENDPOINT=your_search_endpoint" -ForegroundColor Cyan
    Write-Host "SEARCH_SERVICE_QUERY_KEY=your_query_key" -ForegroundColor Cyan
    Write-Host "SEARCH_INDEX_NAME=hotels-index" -ForegroundColor Cyan
}

# Start the application
Write-Host "Starting application..." -ForegroundColor Green
python app.py

Write-Host "Application should be running at http://localhost:5000" -ForegroundColor Green
Write-Host "Health check available at http://localhost:5000/health" -ForegroundColor Green
