#!/bin/bash
set -e

echo "Azure OpenAI PDF Translator LAB - Deploy Script (Linux/macOS)"
echo "-------------------------------------------------------------"

if ! command -v az &> /dev/null; then
    echo "Azure CLI not found. Please install Azure CLI first."
    exit 1
fi

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Usage: ./deploy.sh <subscriptionId> <location> <prefix>"
    exit 1
fi

SUBSCRIPTION_ID=$1
LOCATION=$2
PREFIX=$3
RG="${PREFIX}-rg"

echo "Logging in to Azure CLI..."
az account show &> /dev/null || az login

echo "Setting subscription..."
az account set --subscription "$SUBSCRIPTION_ID"

echo "Creating resource group..."
az group create --name "$RG" --location "$LOCATION"

echo "Deploying Bicep infrastructure..."
az deployment group create \
    --resource-group "$RG" \
    --template-file infra/main.bicep \
    --parameters prefix="$PREFIX" location="$LOCATION"

echo "Fetching outputs..."
KV_NAME=$(az deployment group show --resource-group "$RG" --name $(az deployment group list --resource-group "$RG" --query "[0].name" -o tsv) --query "properties.outputs.keyVaultName.value" -o tsv)
WEBAPP_NAME=$(az deployment group show --resource-group "$RG" --name $(az deployment group list --resource-group "$RG" --query "[0].name" -o tsv) --query "properties.outputs.webAppName.value" -o tsv)
OPENAI_NAME=$(az deployment group show --resource-group "$RG" --name $(az deployment group list --resource-group "$RG" --query "[0].name" -o tsv) --query "properties.outputs.openaiName.value" -o tsv)
OPENAI_ENDPOINT=$(az cognitiveservices account show --name "$OPENAI_NAME" --resource-group "$RG" --query "properties.endpoint" -o tsv)
KV_URI=$(az keyvault show --name "$KV_NAME" --resource-group "$RG" --query "properties.vaultUri" -o tsv)

echo "IMPORTANT: You must manually deploy a model in Azure AI Foundry and set the deployment name (use gpt-4o)."
echo "After deploying the model, store the API key in Key Vault as 'AZURE-OPENAI-API-KEY'."

echo "Assigning Web App managed identity access to Key Vault..."
WEBAPP_PRINCIPAL_ID=$(az webapp identity show --name "$WEBAPP_NAME" --resource-group "$RG" --query "principalId" -o tsv)
az role assignment create --assignee "$WEBAPP_PRINCIPAL_ID" --role "Key Vault Secrets User" --scope "$(az keyvault show --name "$KV_NAME" --query id -o tsv)"

echo "Configuring Web App settings..."
az webapp config appsettings set --name "$WEBAPP_NAME" --resource-group "$RG" --settings \
    AZURE_OPENAI_BASE_URL="$OPENAI_ENDPOINT" \
    KEY_VAULT_URL="$KV_URI"

echo "Packaging app for deployment..."
zip -r app.zip app requirements.txt

echo "Deploying app to Azure Web App..."
az webapp deploy --resource-group "$RG" --name "$WEBAPP_NAME" --src-path app.zip --type zip

echo "Deployment complete!"
echo "Web App URL: https://$WEBAPP_NAME.azurewebsites.net"
