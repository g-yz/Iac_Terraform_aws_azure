# Install Azure CLI on Windows https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
# Install Packer https://www.packer.io/downloads
# Create a resource group 
az group create --name packer-images-rg --location eastus

# Create a service principal 
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }" 

# Obtain your Azure subscription ID
az account show --query "{ subscription_id: id }"
