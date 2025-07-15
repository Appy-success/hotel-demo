# Configuration Checklist for Azure Hotel Search

## 📋 Pre-Deployment Checklist

### ✅ Azure Resources Required
- [ ] Azure Search Service created
- [ ] Azure Cognitive Services resource (for AI enrichment)
- [ ] Hotel data source (JSON/CSV format)
- [ ] Azure Storage Account (if using blob storage for data)

### ✅ Configuration Files to Update

#### 1. Environment Variables (`.env`)
- [ ] Copy `.env.template` to `.env`
- [ ] Update `SEARCH_SERVICE_ENDPOINT` with your search service URL
- [ ] Update `SEARCH_SERVICE_QUERY_KEY` with your query key
- [ ] Verify `SEARCH_INDEX_NAME` matches your index

#### 2. Indexer Configuration (`modify-search/indexer.json`)
- [ ] Update `@odata.context` with your search service URL
- [ ] Update `dataSourceName` with your data source name
- [ ] Verify `targetIndexName` matches your index
- [ ] Verify `skillsetName` matches your skillset

#### 3. Skillset Configuration (`modify-search/skillset.json`)
- [ ] Add Cognitive Services configuration if required
- [ ] Verify skill contexts match your data structure
- [ ] Update input/output field mappings as needed

### ✅ Azure Search Service Setup

#### 1. Create Data Source
```bash
# Use Azure CLI or REST API to create data source
az search datasource create --service-name YOUR_SERVICE --resource-group YOUR_RG --name hotels-sample --type azureblob --connection-string "YOUR_CONNECTION_STRING" --container-name hotels
```

#### 2. Create Index Schema
- [ ] Create index with required fields (HotelId, HotelName, Description, etc.)
- [ ] Add enrichment fields (people, organizations, locations, keyphrases, pii_entities, masked_text)
- [ ] Configure field properties (searchable, filterable, sortable, facetable)

#### 3. Deploy Skillset
```bash
# Deploy using REST API or Azure CLI
curl -X PUT "https://YOUR_SERVICE.search.windows.net/skillsets/hotels-sample-skillset?api-version=2021-04-30-Preview" \
  -H "Content-Type: application/json" \
  -H "api-key: YOUR_ADMIN_KEY" \
  -d @modify-search/skillset.json
```

#### 4. Deploy Indexer
```bash
# Deploy using REST API or Azure CLI
curl -X PUT "https://YOUR_SERVICE.search.windows.net/indexers/hotels-indexer?api-version=2021-04-30-Preview" \
  -H "Content-Type: application/json" \
  -H "api-key: YOUR_ADMIN_KEY" \
  -d @modify-search/indexer.json
```

### ✅ Python Application Setup

#### 1. Virtual Environment
- [ ] Create virtual environment: `python -m venv venv`
- [ ] Activate virtual environment: 
  - Windows: `venv\Scripts\activate`
  - Unix/Mac: `source venv/bin/activate`
- [ ] Verify activation: prompt shows `(venv)`

#### 2. Dependencies
- [ ] Install dependencies: `pip install -r requirements.txt`
- [ ] Verify installation: `pip list`

#### 3. Application Testing
- [ ] Test connection: `python -c "from app import *; print('Import successful')"`
- [ ] Run health check: Start app and visit `http://localhost:5000/health`
- [ ] Test search functionality with sample queries

### ✅ Security Verification

#### 1. Credentials
- [ ] No sensitive information in committed files
- [ ] `.env` file in `.gitignore`
- [ ] API keys stored securely
- [ ] Appropriate access permissions set

#### 2. Network Security
- [ ] Search service accessible from application
- [ ] Firewall rules configured if needed
- [ ] CORS settings configured for web access

### ✅ Testing & Validation

#### 1. Functional Testing
- [ ] Home page loads correctly
- [ ] Search returns results
- [ ] Faceted filtering works
- [ ] Sorting functions properly
- [ ] AI enrichment data displays

#### 2. Performance Testing
- [ ] Search response times acceptable
- [ ] Large result sets handled properly
- [ ] Error handling works correctly

#### 3. UI/UX Testing
- [ ] Responsive design on mobile
- [ ] Search examples work
- [ ] No JavaScript errors in console
- [ ] Error pages display correctly

## 🚨 Common Issues & Solutions

### Issue: "Connection refused" or "Service not found"
**Solution:** 
- Verify `SEARCH_SERVICE_ENDPOINT` in `.env`
- Check Azure Search service is running
- Verify network connectivity

### Issue: "Authentication failed"
**Solution:**
- Verify `SEARCH_SERVICE_QUERY_KEY` in `.env`
- Check key hasn't expired
- Ensure using Query Key (not Admin Key) for read-only operations

### Issue: "Index not found"
**Solution:**
- Verify `SEARCH_INDEX_NAME` in `.env`
- Check index exists in Azure Search service
- Verify index schema includes required fields

### Issue: "No enrichment data"
**Solution:**
- Check skillset deployment
- Verify Cognitive Services configuration
- Run indexer to process data

### Issue: "Virtual environment not working"
**Solution:**
- Ensure virtual environment is activated
- Verify Python version compatibility
- Check dependencies are installed in correct environment

## 📞 Support Resources

- **Azure Search Documentation**: https://docs.microsoft.com/azure/search/
- **Python SDK Documentation**: https://docs.microsoft.com/python/api/azure-search-documents/
- **Cognitive Services**: https://docs.microsoft.com/azure/cognitive-services/
- **Flask Documentation**: https://flask.palletsprojects.com/

## ✅ Deployment Ready Checklist

Before going to production:
- [ ] All configuration files updated
- [ ] Sensitive information secured
- [ ] Azure resources provisioned and configured
- [ ] Application tested thoroughly
- [ ] Error handling verified
- [ ] Performance optimized
- [ ] Security measures implemented
- [ ] Monitoring/logging configured
