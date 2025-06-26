variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the image and VM are located."
}

variable "location" {
  type        = string
  description = "Azure region to deploy the resources in."
}

variable "image_name" {
  type        = string
  description = "The name of the custom image created by Packer."
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine."
}

variable "admin_username" {
  type        = string
  description = "Admin username for the VM."
}

variable "public_key_path" {
  type        = string
  description = "Path to the SSH public key."
  default     = "~/.ssh/id_rsa.pub"
}
