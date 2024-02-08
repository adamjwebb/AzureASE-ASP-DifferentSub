param namingPrefix string = uniqueString(resourceGroup().id)
param location string = resourceGroup().location

param appServiceEnvironmentName string
param appServiceEnvironmentSubscriptionId string
param appServiceEnvironmentResourceGroupName string


resource appServiceEnvironment 'Microsoft.Web/hostingEnvironments@2022-09-01' existing = {
  name: appServiceEnvironmentName
  scope: resourceGroup(appServiceEnvironmentSubscriptionId, appServiceEnvironmentResourceGroupName)
}

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: '${namingPrefix}-asp'
  location: location
  sku: {
    tier: 'IsolatedV2'
    name: 'I1V2'
  }
  kind: 'linux'
  properties: {
    reserved: true
    hostingEnvironmentProfile: {
      id: appServiceEnvironment.id
    }
  }
}

resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: '${namingPrefix}-app'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    hostingEnvironmentProfile: {
      id: appServiceEnvironment.id
    }
  }
}
