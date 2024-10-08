targetScope = 'subscription'

param location string
param serverFarmSku string

resource appServiceResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'appServiceLi'
  location: location
}

module appServiceLiResourcesDeployment 'appService/appService.bicep' = {
  scope: appServiceResourceGroup
  name: 'appServiceLiDeployment'
  params: {
    location: location
    serverFarmSku: serverFarmSku
  }
}
