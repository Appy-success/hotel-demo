@echo off
REM Azure Hotel Search Application Deployment Script for Windows

echo Setting up Azure Hotel Search Application...

REM Check if .env file exists
if not exist .env (
    echo.
    echo WARNING: .env file not found!
    echo Please copy .env.template to .env and configure your Azure Search credentials.
    echo.
    echo Required variables:
    echo SEARCH_SERVICE_ENDPOINT=https://your-search-service.search.windows.net
    echo SEARCH_SERVICE_QUERY_KEY=your-query-key
    echo SEARCH_INDEX_NAME=hotels-index
    echo.
    if exist .env.template (
        echo Template file found. Copying to .env...
        copy .env.template .env
        echo Please edit .env file with your actual Azure credentials before continuing.
        pause
    ) else (
        echo ERROR: .env.template file not found!
        pause
        exit /b 1
    )
)

REM Create virtual environment
echo Creating virtual environment...
python -m venv venv
if errorlevel 1 (
    echo ERROR: Failed to create virtual environment
    pause
    exit /b 1
)

REM Activate virtual environment
echo Activating virtual environment...
call venv\Scripts\activate
if errorlevel 1 (
    echo ERROR: Failed to activate virtual environment
    pause
    exit /b 1
)

REM Install dependencies
echo Installing dependencies...
pip install --upgrade pip
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

REM Check configuration
echo Checking configuration...
python -c "from dotenv import load_dotenv; import os; load_dotenv(); print(f'Search Endpoint: {os.getenv(\"SEARCH_SERVICE_ENDPOINT\", \"NOT SET\")}'); print(f'Index Name: {os.getenv(\"SEARCH_INDEX_NAME\", \"NOT SET\")}')"

REM Start the application
echo.
echo Starting Azure Hotel Search Application...
echo Application will be available at: http://localhost:5000
echo Health check available at: http://localhost:5000/health
echo.
echo Press Ctrl+C to stop the application
echo.
python app.py

pause
