@description('Location for resources, e.g. uksouth')
param location string

@description('Storage account name (lowercase, 3-24 chars, globally unique)')
param storageAccountName string

resource stg 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: jacklabs123
  location: location
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
    staticWebsite: {
      enabled: true
      indexDocument: 'index.html'
      error404Document: '404.html'
    }
  }
}

output staticWebEndpoint string = stg.properties.primaryEndpoints.web
