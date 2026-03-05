param prefix string
param location string = resourceGroup().location

var rgName = '${prefix}-rg'
var appServicePlanName = '${prefix}-plan'
var webAppName = '${prefix}-web'
var keyVaultName = toLower('${prefix}kv')
var appInsightsName = '${prefix}-ai'
var openaiName = '${prefix}-aoai'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: rgName
}

resource plan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource web 'Microsoft.Web/sites@2022-03-01' = {
  name: webAppName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.11'
    }
    httpsOnly: true
  }
  identity: {
    type: 'SystemAssigned'
  }
}

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enableRbacAuthorization: true
    enablePurgeProtection: false
    enableSoftDelete: true
    publicNetworkAccess: 'Enabled'
  }
}

resource ai 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

resource openai 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: openaiName
  location: location
  kind: 'OpenAI'
  sku: {
    name: 'S0'
  }
  properties: {
    apiProperties: {
      enableDynamicThrottling: true
    }
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

output webAppName string = webAppName
output keyVaultName string = keyVaultName
output openaiName string = openaiName
output appInsightsName string = appInsightsName
output webAppIdentityPrincipalId string = web.identity.principalId
output keyVaultUri string = kv.properties.vaultUri
output openaiEndpoint string = openai.properties.endpoint
