#!/bin/bash
# Azure Hotel Search Application Deployment Script

echo "Setting up Azure Hotel Search Application..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo ""
    echo "WARNING: .env file not found!"
    echo "Please copy .env.template to .env and configure your Azure Search credentials."
    echo ""
    echo "Required variables:"
    echo "SEARCH_SERVICE_ENDPOINT=https://your-search-service.search.windows.net"
    echo "SEARCH_SERVICE_QUERY_KEY=your-query-key"
    echo "SEARCH_INDEX_NAME=hotels-index"
    echo ""
    
    if [ -f .env.template ]; then
        echo "Template file found. Copying to .env..."
        cp .env.template .env
        echo "Please edit .env file with your actual Azure credentials before continuing."
        read -p "Press Enter to continue after updating .env file..."
    else
        echo "ERROR: .env.template file not found!"
        exit 1
    fi
fi

# Create virtual environment
echo "Creating virtual environment..."
python3 -m venv venv || python -m venv venv
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to create virtual environment"
    exit 1
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to activate virtual environment"
    exit 1
fi

# Install dependencies
echo "Installing dependencies..."
pip install --upgrade pip
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to install dependencies"
    exit 1
fi

# Check configuration
echo "Checking configuration..."
python -c "from dotenv import load_dotenv; import os; load_dotenv(); print(f'Search Endpoint: {os.getenv(\"SEARCH_SERVICE_ENDPOINT\", \"NOT SET\")}'); print(f'Index Name: {os.getenv(\"SEARCH_INDEX_NAME\", \"NOT SET\")}')"

# Start the application
echo ""
echo "Starting Azure Hotel Search Application..."
echo "Application will be available at: http://localhost:5000"
echo "Health check available at: http://localhost:5000/health"
echo ""
echo "Press Ctrl+C to stop the application"
echo ""
python app.py
