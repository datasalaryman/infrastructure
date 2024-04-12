provider "aws" {
  region = "ap-southeast-1"
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

variable "key_pair" {
  description = "name of the key pair given to root access the instances"
}

data "aws_ami" "debian" {

  filter {
    name   = "image-id"
    values = ["ami-0373adef92f28feef"]
  }

  owners = ["136693071363"]
}

module "jumpbox" {
  source = "../../low-level/ec2"
  instance_name = "k8s-hard-way-jumpbox"
  ami = data.aws_ami.debian.id
  type = "m6g.medium"
  root_size = 10
  key_pair = var.key_pair
}

module "server" {
  source = "../../low-level/ec2"
  instance_name = "k8s-hard-way-server"
  ami = data.aws_ami.debian.id
  type = "m6g.medium"
  root_size = 20
  key_pair = var.key_pair
}

module "node-0" {
  source = "../../low-level/ec2"
  instance_name = "k8s-hard-way-node-0"
  ami = data.aws_ami.debian.id
  type = "m6g.medium"
  root_size = 20
  key_pair = var.key_pair
}

module "node-1" {
  source = "../../low-level/ec2"
  instance_name = "k8s-hard-way-node-1"
  ami = data.aws_ami.debian.id
  type = "m6g.medium"
  root_size = 20
  key_pair = var.key_pair
}

output "aws_ami_arn" {
  value = data.aws_ami.debian.arn
}

output "aws_instance_arns" {
  value = {
    jumpbox=module.jumpbox.instance_arn
    server=module.server.instance_arn
    node_1=module.node-0.instance_arn
    node_2=module.node-1.instance_arn
  }
}