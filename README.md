# Install packer and terraform

´´´
choco install packer
choco install terraform
´´´

https://developer.hashicorp.com/packer
https://developer.hashicorp.com/terraform

# AWS

## Credentials

´´´
export AWS_ACCESS_KEY_ID="xxxxxxxxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
´´´

## Build

´´´
packer init .
packer validate
packer build aws-nodejs.pkr.hcl
´´´

## Deploy

´´´
terraform init
terraform validate
terraform plan
terraform apply
´´´

# Azure

## Credentials

´´´
export ARM_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
´´´

## Build

´´´
packer init .
packer validate
packer build azure-nodejs.pkr.hcl
´´´

## Deploy

´´´
terraform init
terraform validate
terraform plan
terraform apply
´´´
