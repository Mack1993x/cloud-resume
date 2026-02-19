
@description('Location for resources')
param location string

@description('Existing or new storage account name (must be globally unique, lowercase)')
param storageAccountName string

@description('Tags for the storage account')
param tags object = {}

resource stg 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: jacklabs123
  location: location
  tags: tags
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    publicNetworkAccess: 'Enabled'
  }
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  name: '${stg.name}/default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    staticWebsite: {
      enabled: true
      indexDocument: 'index.html'
      error404Document: '404.html'
    }
  }
}

@description('Static website endpoint')
output staticWebEndpoint string = stg.properties.primaryEndpoints.web
