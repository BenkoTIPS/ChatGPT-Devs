@description('The name of the app')
param appName string
param envName string

var siteName = '${prefix}-site'
var prefix = '${appName}-${envName}'
var hostName = '${prefix}-host'

resource host 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: hostName
  location: resourceGroup().location
  kind: 'app,linux'
  sku: {
    name: 'S1'
    capacity: 1
  }
  properties: {
    reserved: true
  }
}

resource site 'Microsoft.Web/sites@2020-12-01' = {
  name: siteName
  location: resourceGroup().location
  kind: 'linux,app'
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/${hostName}': 'Resource'
    displayName: siteName
  }
  properties: {
    serverFarmId: host.id
  }
}

resource siteName_appsettings 'Microsoft.Web/sites/config@2015-08-01' = {
  parent: site
  name: 'appsettings'
  location: resourceGroup().location
  tags: {
    displayName: 'config'
  }
  properties: {
    openaiKey: 'keyvalue'
    openaiUrl: 'url'
  }
}