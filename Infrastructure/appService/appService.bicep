param location string
param serverFarmSku string
param appOs string

resource serverFarm 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'appService-${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: serverFarmSku
  }

  kind: appOs
  properties: {
    reserved: true //must be to host app service as a linux
  }
}

resource webapp 'Microsoft.Web/sites@2023-12-01' = {
  name: 'webApp-${uniqueString(resourceGroup().id)}'
  location: location
  kind: appOs
  
  properties: {
    serverFarmId: serverFarm.id
    siteConfig: {
      linuxFxVersion: 'DOCKER|kamil4921/appservice:1.0' // in case if you want to host your webappp from container and use dockerhub as a repo
    }
    reserved: true
  }
}
