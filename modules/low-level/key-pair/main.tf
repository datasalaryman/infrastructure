provider "aws" {
  region = "ap-southeast-1"
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

variable "key_name_prefix" {
  type = string
  description = "Unique prefix name for the public key"
}

variable "public_keys_file" {
  type = string
  description = "file containing list of allowable public keys, separated by newline"
}

locals {
  public_keys = [for line in split("\n", file("${var.public_keys_file}")): chomp(line)]
}

resource "aws_key_pair" "key" {
  for_each = {for key in local.public_keys: index(local.public_keys, key) => key}
  key_name_prefix = var.key_name_prefix
  public_key = each.value
}

output "key_pair_names" {
  value = [
    for key in aws_key_pair.key: key.id
  ]
}