provider "aws" {
  region = "ap-southeast-1"
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

variable "instance_name" {
  description = "name assigned to the instance when started"
}

variable "ami" {
  description = "ami id specified for this instance"
}

variable "type" {
  description = "aws instance type"
}

variable "key_pair" {
  description = "name of the root key used to access the instance"
}

variable "root_size" {
  description = "size of the root block device in gibibytes"
  default = 8
}

resource "aws_instance" "instance" {
  ami = var.ami
  instance_type = var.type

  key_name = var.key_pair

  root_block_device {
    volume_size = var.root_size
  }

  tags = {
    Name = var.instance_name
  }
}

output "instance_arn" {
  value = aws_instance.instance.arn
}