variable "region" {
  type = string
  description = "region where the vpc will be created"
  default = "ap-southeast-1"
}

variable "block" {
  type = string
  description = "cidr block"
}

variable "open_internet" {
  type = bool
  description = "whether an internet gateway will be provisioned for this vpc"
  default = true
}

provider "aws" {
  region = var.region
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

resource "aws_vpc" "vpc" {
  cidr_block = var.block
}

resource "aws_internet_gateway" "internet_gateway" {
  count = var.open_internet ? 1 : 0
  vpc_id = aws_vpc.vpc.id
}