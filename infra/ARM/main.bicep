
targetScope = 'subscription'

param appName string 
param envName string = 'bicep'
param loc string = 'westeurope'

var rgName =  '${appName}-${envName}-rg'

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: rgName
  location: loc
}

module site 'mysite.bicep' = {
  scope: rg
  name: 'bicep-site'
  params: {
    appName: appName
    envName: envName
  }
}
