param aspName string = 'asp-nonprod-win-01'
param operatingSystem string = 'windows'
param appServicePlanSize string = 'I1v2'
param aseEnvironment string = 'NonProduction'

param location string = resourceGroup().location
param tags object = {}

param webAppName string = 'app-mywebapp-dev-01'
param managedIdentityName string = 'id-mywebapp-dev-01'

module appServicePlan 'ts/CoreSpecs:ASPonASE:2022-12-02' = {
  name: 'deploy-appserviceplan'
  params: {
    aspName: aspName
    aseEnvironment: aseEnvironment
    operatingSystem: operatingSystem
    appServicePlanSize: appServicePlanSize
    location: location
    tags: tags
  }
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

module webApp 'ts/CoreSpecs:WeAppOnASE:2022-12-02' = {
  name: 'deploy-webapp'
  params:{
    aspName: aspName
    webAppName: webAppName
    managedIdentityName: managedIdentity.name
    location: location
  }
  dependsOn: [appServicePlan]
}
