targetScope = 'subscription'

param location string
param serverFarmSku string
param appOs string

resource appServiceResourceGroup 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: 'appServiceLi'
  location: location
}

module appServiceLiResourcesDeployment 'appService/appService.bicep' = {
  scope: appServiceResourceGroup
  name: 'appServiceLiDeployment'
  params: {
    location: location
    serverFarmSku: serverFarmSku
    appOs: appOs
  }
}