packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
  }
}

variable "region" {
  type    = string
  default = "us-east-1"
}
variable "instance_type" {
  type    = string
  default = "t3.micro"
}
variable "ami_name" {
  type    = string
  default = "nodejs-prod-ubuntu-{{timestamp}}"
}

source "amazon-ebs" "node_app" {
  region        = var.region
  instance_type = var.instance_type
  ssh_username  = "ubuntu"
  ami_name      = var.ami_name

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
}

build {
  name    = "nodejs-production-aws"
  sources = ["source.amazon-ebs.node_app"]

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
