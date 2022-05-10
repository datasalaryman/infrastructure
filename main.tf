terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.16.0"
    }
  }
}

variable "linode_token" {
  description = "Linode personal access token"
  sensitive = true
}

variable "root_pass" {
  description = "Linode instance default root password"
  sensitive = true
}

provider "linode" {
    token = var.linode_token
}

resource "linode_instance" "dev_server" {
    label = "dev_server"
    image = "linode/ubuntu18.04"
    region = "ap-south"
    type = "g6-nanode-1"
    root_pass = var.root_pass
}