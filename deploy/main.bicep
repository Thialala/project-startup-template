param aspName string = 'asp-nonprod-win-01'
param operatingSystem string = 'windows'
param appServicePlanSize string = 'I1v2'
param aseEnvironment string = 'NonProduction'

param location string = resourceGroup().location
param tags object = {}

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
