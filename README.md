# IaC using Packer and terraform

## Architecture

![Architecture](https://drive.google.com/uc?export=view&id=15tLvjcpAi2MJJQjzmgiXSHWycf_RgxLu)


## Install packer and terraform

```ssh
choco install packer
choco install terraform
```

https://developer.hashicorp.com/packer
https://developer.hashicorp.com/terraform

## AWS

### Credentials

```ssh
export AWS_ACCESS_KEY_ID="xxxxxxxxxxxxxxx"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

### Build

```ssh
packer init .
packer validate
packer build aws-nodejs.pkr.hcl
```

### Deploy

```ssh
terraform init
terraform validate
terraform plan
terraform apply
```

## Azure

### Credentials

```ssh
export ARM_CLIENT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_CLIENT_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export ARM_TENANT_ID="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

### Build

```ssh
packer init .
packer validate
packer build azure-nodejs.pkr.hcl
```

### Deploy

```ssh
terraform init
terraform validate
terraform plan
terraform apply
```
