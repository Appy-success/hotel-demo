@echo off
REM Hotel Search Application Deployment Script for Windows

echo Setting up Hotel Search Application...

REM Create virtual environment
python -m venv venv
call venv\Scripts\activate

REM Install dependencies
echo Installing dependencies...
pip install -r requirements.txt

REM Check environment variables
echo Checking environment configuration...
if not exist .env (
    echo Warning: .env file not found. Please create it with your Azure Search credentials.
    echo Required variables:
    echo SEARCH_SERVICE_ENDPOINT=your_search_endpoint
    echo SEARCH_SERVICE_QUERY_KEY=your_query_key
    echo SEARCH_INDEX_NAME=hotels-index
)

REM Start the application
echo Starting application...
python app.py

echo Application should be running at http://localhost:5000
echo Health check available at http://localhost:5000/health
pause
