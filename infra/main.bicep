// main.bicep - Azure Cognitive Search deployment for hotel demo

param searchServiceName string = 'hotelsearch${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param searchSku string = 'standard'
param searchIndexName string = 'hotels-sample-index'
param searchIndexerName string = 'hotels-sample-indexer'
param searchSkillsetName string = 'hotels-sample-skillset'

resource searchService 'Microsoft.Search/searchServices@2023-07-01-preview' = {
  name: searchServiceName
  location: location
  sku: {
    name: searchSku
  }
  properties: {
    hostingMode: 'default'
    partitionCount: 1
    replicaCount: 1
  }
}

output searchServiceEndpoint string = 'https://${searchService.name}.search.windows.net'
output searchIndexName string = searchIndexName
output searchIndexerName string = searchIndexerName
output searchSkillsetName string = searchSkillsetName

// Note: Index, Indexer, and Skillset resources are typically created via REST API or Azure SDK after the service is provisioned.
// You can automate this with deployment scripts or Azure Functions if needed.
