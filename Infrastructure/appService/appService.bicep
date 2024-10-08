param location string
param serverFarmSku string

resource serverFarm 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'appService-${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: serverFarmSku
  }

  properties: {
    reserved: true //must be to host app service as a linux
  }
}

resource webapp 'Microsoft.Web/sites@2023-12-01' = {
  name: 'webApp-${uniqueString(resourceGroup().id)}'
  location: location
  
  properties: {
    serverFarmId: serverFarm.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|kamil4921/appservice:1' // in case if you want to host your webappp from container and use dockerhub as a repo
    }
    reserved: true
  }
}
