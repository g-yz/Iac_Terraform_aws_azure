packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 1.0.0"
    }
  }
}

variable "client_id" {
  type    = string
  default = env("ARM_CLIENT_ID")
}

variable "client_secret" {
  type    = string
  default = env("ARM_CLIENT_SECRET")
}

variable "tenant_id" {
  type    = string
  default = env("ARM_TENANT_ID")
}

variable "subscription_id" {
  type    = string
  default = env("ARM_SUBSCRIPTION_ID")
}

variable "location" {
  type    = string
  default = "East US"
}

variable "resource_group" {
  type    = string
  default = "packer-images-rg"
}

variable "image_name" {
  type    = string
  default = "ubuntu-base-image"
}

source "azure-arm" "node_image" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id

  managed_image_name                = var.image_name
  managed_image_resource_group_name = var.resource_group
  location                          = var.location
  vm_size                           = "Standard_B1s"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18_04-lts-gen2"
  image_version   = "latest"
}

build {
  name    = "nodejs-azure-image"
  sources = ["source.azure-arm.node_image"]

  provisioner "file" {
    source      = "../../app/server.js"
    destination = "/tmp/server.js"
  }

  provisioner "file" {
    source      = "../../config/nginx/node_production.conf"
    destination = "/tmp/node_production.conf"
  }

  provisioner "shell" {
    script          = "provision.sh"
    execute_command = "sudo bash '{{ .Path }}'"
  }
}
