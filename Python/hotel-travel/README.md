# Azure Hotel Search Application - Optimized Version

This Flask application provides a modern, AI-powered search interface for hotel data using Azure Cognitive Search with intelligent enrichment capabilities.

## 🎨 UI/UX Improvements

### Modern Design Elements
- **Clean Typography**: Modern Segoe UI font family with improved hierarchy
- **Gradient Color Scheme**: Purple/blue gradient theme (#667eea to #764ba2)
- **Card-Based Layout**: Clean, modern card design for better content organization
- **Responsive Design**: Mobile-friendly layout with proper breakpoints
- **Interactive Elements**: Hover effects and smooth transitions

### Enhanced User Experience
- **Visual Icons**: Added emoji icons for better visual guidance
- **Improved Forms**: Better styled input fields and buttons
- **Clear Navigation**: Intuitive layout with consistent spacing
- **Error Handling**: User-friendly error pages with clear messaging
- **Loading States**: Better visual feedback for user actions

## Key Optimizations Applied

### 1. **Skillset Optimizations** (`modify-search/skillset.json`)
- **Fixed Context**: Changed from `/document/HotelId` to `/document` for proper document-level processing
- **Improved Input Source**: Now extracts entities from `/document/Description` instead of HotelId
- **Optimized Categories**: Focused on relevant categories (Person, Organization, Location, DateTime, Address)
- **Enhanced PII Detection**: Added specific PII categories for phone numbers, emails, and addresses

### 2. **Indexer Optimizations** (`modify-search/indexer.json`)
- **Updated Field Mappings**: Corrected source field paths from `/document/HotelId/*` to `/document/*`
- **Removed Null Mapping Functions**: Cleaned up unnecessary null mapping function references

### 3. **Python Application Optimizations** (`app.py`)
- **Enhanced Error Handling**: Added proper exception handling with Azure-specific error types
- **Improved Logging**: Added comprehensive logging for debugging and monitoring
- **Search Query Optimization**: 
  - Changed search mode from "all" to "any" for better hotel search results
  - Added hotel-specific facets (Category, Tags, Rating)
  - Optimized field selection for hotel data
  - Added result limiting for better performance
- **Connection Management**: Implemented proper Azure credential handling
- **Health Check Endpoint**: Added `/health` endpoint for monitoring
- **Enhanced Filtering**: Added support for multiple facet types with proper OData filtering

### 4. **Template Optimizations** (`templates/search.html`)
- **Hotel-Specific UI**: Redesigned for hotel search results
- **Enhanced Faceted Search**: Added category, tags, and rating filters
- **Improved Result Display**: Better presentation of hotel information
- **AI Enrichment Display**: Shows extracted entities, key phrases, and locations
- **Search Highlighting**: Proper highlighting for hotel names and descriptions

### 5. **CSS Improvements** (`static/css/site.css`)
- **Modern Styling**: Added hotel-specific styles
- **Better Typography**: Improved readability and hierarchy
- **Enhanced Interactivity**: Better button and form styling
- **Responsive Design**: Improved mobile-friendly layout

### 6. **Configuration & Deployment**
- **Environment Configuration**: Updated to use hotels-index
- **Requirements Management**: Added proper Python dependencies
- **Deployment Scripts**: Created both Windows and Unix deployment scripts
- **Health Monitoring**: Added connection testing capabilities

## Architecture Benefits

### Performance Improvements
- **Reduced Query Overhead**: Limited result sets and optimized field selection
- **Efficient Faceting**: Focused facets reduce processing time
- **Connection Pooling**: Proper Azure SDK usage for connection management

### Reliability Enhancements
- **Comprehensive Error Handling**: Graceful handling of search service failures
- **Logging & Monitoring**: Detailed logging for troubleshooting
- **Health Checks**: Proactive monitoring of service connectivity

### Security Features
- **Environment Variables**: Secure credential management
- **PII Detection**: Automatic detection and masking of sensitive information
- **Input Validation**: Proper validation of search inputs

## Usage

### Quick Start
```bash
# Windows
deploy.bat

# Unix/Linux/Mac
chmod +x deploy.sh
./deploy.sh
```

### Manual Setup

#### Step 1: Create and Activate Virtual Environment

**Windows:**
```batch
# Create virtual environment
python -m venv venv

# Activate virtual environment
venv\Scripts\activate

# Your prompt should now show (venv) at the beginning
```

**Unix/Linux/Mac:**
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
source venv/bin/activate

# Your prompt should now show (venv) at the beginning
```

#### Step 2: Install Dependencies
```bash
# Install required packages
pip install -r requirements.txt
```

#### Step 3: Configure Environment Variables
Create a `.env` file in the project root with your Azure Search credentials:
```bash
# Set environment variables in .env file
SEARCH_SERVICE_ENDPOINT=your_search_endpoint
SEARCH_SERVICE_QUERY_KEY=your_query_key
SEARCH_INDEX_NAME=hotels-index
```

#### Step 4: Run the Application
```bash
# Run application
python app.py
```

#### Step 5: Access the Application
- Open your browser and go to: `http://localhost:5000`
- Health check available at: `http://localhost:5000/health`

### Deactivating Virtual Environment
When you're done working with the application:
```bash
# Deactivate virtual environment
deactivate
```

### Search Features
- **Text Search**: Search hotel names and descriptions
- **Faceted Filtering**: Filter by category, tags, or rating
- **Sort Options**: Sort by relevance, name, rating, or renovation date
- **AI Insights**: View extracted entities, key phrases, and locations

## API Endpoints

- `GET /` - Home page
- `GET /search` - Search interface and results
- `GET /health` - Health check endpoint

## Search Parameters

- `search` - Search query text
- `facet` - Facet value for filtering
- `facet_type` - Type of facet (Category, Tags, Rating)
- `sort` - Sort field (relevance, name, rating, date)

## Troubleshooting

### Application Issues
1. **Connection Issues**: Check `/health` endpoint
2. **No Results**: Verify index name and search service configuration
3. **Slow Performance**: Check Azure Search service tier and quotas
4. **Enrichment Issues**: Verify skillset and indexer configurations

### Virtual Environment Issues

#### Problem: Virtual environment not activating
**Windows:**
```batch
# If activation fails, try:
venv\Scripts\activate.bat
# or
venv\Scripts\activate.ps1
```

**Unix/Linux/Mac:**
```bash
# If activation fails, try:
source venv/bin/activate
# or check if venv folder exists
ls -la venv/
```

#### Problem: "python" command not found
```bash
# Try using python3 instead
python3 -m venv venv
python3 app.py

# Or on Windows, try:
py -m venv venv
py app.py
```

#### Problem: Permission denied on Windows
```powershell
# Run PowerShell as Administrator, then:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

#### Problem: Packages not installing
```bash
# Make sure virtual environment is activated
# Upgrade pip first
pip install --upgrade pip

# Then install requirements
pip install -r requirements.txt
```

#### Problem: "Module not found" errors
```bash
# Make sure virtual environment is activated
# Check if packages are installed in the virtual environment
pip list

# If not, install them
pip install -r requirements.txt
```

#### Problem: Virtual environment in wrong location
```bash
# Make sure you're in the correct directory
cd path/to/margies-travel

# Create virtual environment in current directory
python -m venv venv
```

## Next Steps

1. **Deploy Updated Configurations**: Apply the optimized skillset and indexer to your Azure Search service
2. **Monitor Performance**: Use the health check endpoint for monitoring
3. **Customize UI**: Modify templates and CSS for your specific needs
4. **Add Features**: Consider adding more sophisticated filtering or sorting options

## Dependencies

- Flask 2.3.2
- azure-search-documents 11.4.0
- azure-core 1.28.0
- python-dotenv 1.0.0
- gunicorn 21.2.0 (for production deployment)

## 🔧 Virtual Environment Management

### Why Use Virtual Environments?
Virtual environments help you:
- **Isolate Dependencies**: Keep project dependencies separate from system Python
- **Avoid Conflicts**: Prevent version conflicts between different projects
- **Reproduce Environment**: Ensure consistent setup across different machines
- **Clean Installation**: Easy to remove and recreate if needed

### Virtual Environment Commands

#### Windows Commands:
```batch
# Create virtual environment
python -m venv venv

# Activate virtual environment
venv\Scripts\activate

# Deactivate virtual environment
deactivate

# Remove virtual environment (delete folder)
rmdir /s venv
```

#### Unix/Linux/Mac Commands:
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
source venv/bin/activate

# Deactivate virtual environment
deactivate

# Remove virtual environment (delete folder)
rm -rf venv
```

### Verifying Virtual Environment
When your virtual environment is activated, you should see:
- `(venv)` at the beginning of your command prompt
- Python packages installed only in this environment
- `pip list` shows only project-specific packages

### Installing Packages in Virtual Environment
```bash
# Make sure virtual environment is activated first
# Your prompt should show (venv)

# Install packages from requirements.txt
pip install -r requirements.txt

# Install individual packages
pip install package_name

# List installed packages
pip list

# Generate requirements.txt
pip freeze > requirements.txt
```

## 🔍 Search Examples

### Amenity-Based Searches
- **"pool"** - Find hotels with swimming pools
- **"spa"** - Discover hotels with spa facilities
- **"gym"** - Hotels with fitness centers
- **"breakfast"** - Hotels offering breakfast
- **"gaming"** - Hotels with gaming/casino facilities
- **"restaurant"** - Hotels with dining options

### Experience-Based Searches
- **"luxury"** - High-end luxury hotels
- **"resort"** - Resort-style accommodations
- **"family"** - Family-friendly hotels
- **"business"** - Business-oriented hotels
- **"romantic"** - Perfect for couples

### Location-Based Searches
- **"downtown"** - City center hotels
- **"airport"** - Near airport locations
- **"beach"** - Beachfront properties
- **"mountain"** - Mountain resort hotels

### Combination Searches
- **"luxury spa resort"** - High-end spa resorts
- **"family pool hotel"** - Family hotels with pools
- **"business downtown"** - Business hotels in city center
- **"gaming resort pool"** - Gaming resorts with pools

### Rating-Based Searches
- Filter by star ratings (3+, 4+, 5 stars)
- Sort by highest rated first
- Find recently renovated properties

## 🔒 Security & Configuration

### Sensitive Information Removed
This repository has been sanitized to remove all sensitive information including:
- **Azure Search Service URLs** - Replaced with placeholder `YOUR_SEARCH_SERVICE_NAME`
- **API Keys** - Replaced with placeholder `YOUR_SEARCH_SERVICE_QUERY_KEY_HERE`
- **Connection Strings** - Removed and replaced with template values
- **Subscription IDs** - Removed from configuration files

### Required Configuration Updates

**Before deploying, you must update these files:**

1. **`.env` file** - Configure your Azure Search credentials:
   ```bash
   SEARCH_SERVICE_ENDPOINT=https://your-search-service.search.windows.net
   SEARCH_SERVICE_QUERY_KEY=your-actual-query-key
   SEARCH_INDEX_NAME=hotels-index
   ```

2. **`modify-search/indexer.json`** - Update these fields:
   ```json
   {
     "@odata.context": "https://YOUR_SEARCH_SERVICE.search.windows.net/...",
     "dataSourceName": "YOUR_DATA_SOURCE_NAME"
   }
   ```

3. **Azure Cognitive Services** - Add your Cognitive Services configuration to skillset if needed

### Environment Template
Use `.env.template` as a reference for required environment variables:
```bash
cp .env.template .env
# Then edit .env with your actual values
```

### Security Best Practices
- **Never commit credentials** to version control
- **Use Azure Key Vault** for production environments
- **Rotate keys regularly** through Azure Portal
- **Use managed identities** when possible
- **Restrict access** with appropriate RBAC roles
