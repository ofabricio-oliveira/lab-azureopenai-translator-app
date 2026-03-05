param(
    [Parameter(Mandatory=$true)][string]$subscriptionId,
    [Parameter(Mandatory=$true)][string]$location,
    [Parameter(Mandatory=$true)][string]$prefix
)

Write-Host "Azure OpenAI PDF Translator LAB - Deploy Script (PowerShell)"
Write-Host "-------------------------------------------------------------"

if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
    Write-Error "Azure CLI not found. Please install Azure CLI first."
    exit 1
}

$rg = "$prefix-rg"

Write-Host "Logging in to Azure CLI..."
az account show | Out-Null
if ($LASTEXITCODE -ne 0) { az login }

Write-Host "Setting subscription..."
az account set --subscription $subscriptionId

Write-Host "Creating resource group..."
az group create --name $rg --location $location

Write-Host "Deploying Bicep infrastructure..."
az deployment group create `
    --resource-group $rg `
    --template-file infra/main.bicep `
    --parameters prefix=$prefix location=$location

Write-Host "Fetching outputs..."
$deploymentName = (az deployment group list --resource-group $rg --query "[0].name" -o tsv)
$kvName = (az deployment group show --resource-group $rg --name $deploymentName --query "properties.outputs.keyVaultName.value" -o tsv)
$webAppName = (az deployment group show --resource-group $rg --name $deploymentName --query "properties.outputs.webAppName.value" -o tsv)
$openaiName = (az deployment group show --resource-group $rg --name $deploymentName --query "properties.outputs.openaiName.value" -o tsv)
$openaiEndpoint = (az cognitiveservices account show --name $openaiName --resource-group $rg --query "properties.endpoint" -o tsv)
$kvUri = (az keyvault show --name $kvName --resource-group $rg --query "properties.vaultUri" -o tsv)

Write-Host "IMPORTANT: You must manually deploy a model in Azure AI Foundry and set the deployment name (use gpt-4o)."
Write-Host "After deploying the model, store the API key in Key Vault as 'AZURE-OPENAI-API-KEY'."

Write-Host "Assigning Web App managed identity access to Key Vault..."
$webAppPrincipalId = (az webapp identity show --name $webAppName --resource-group $rg --query "principalId" -o tsv)
az role assignment create --assignee $webAppPrincipalId --role "Key Vault Secrets User" --scope (az keyvault show --name $kvName --query id -o tsv)

Write-Host "Configuring Web App settings..."
az webapp config appsettings set --name $webAppName --resource-group $rg --settings `
    AZURE_OPENAI_BASE_URL=$openaiEndpoint `
    KEY_VAULT_URL=$kvUri

Write-Host "Packaging app for deployment..."
Compress-Archive -Path app,requirements.txt -DestinationPath app.zip -Force

Write-Host "Deploying app to Azure Web App..."
az webapp deploy --resource-group $rg --name $webAppName --src-path app.zip --type zip

Write-Host "Deployment complete!"
Write-Host "Web App URL: https://$webAppName.azurewebsites.net"
