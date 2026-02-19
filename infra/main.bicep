@description('Location for resources, e.g. uksouth')
param location string

@description('Storage account name (lowercase, 3-24 chars, globally unique)')
param storageAccountName string

resource stg 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    allowBlobPublicAccess: true
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
  }
}

output staticWebEndpoint string = stg.properties.primaryEndpoints.web
