provider "aws" {
  region = "ap-southeast-1"
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

variable "name" {
  type        = string
  description = "enables private zone, specify AWS vpc id"
}

variable "vpc_id" {
  type        = string
  description = "enables private zone, specify AWS vpc id"
  default     = null
}

resource "aws_route53_zone" "zone" {
  name = var.name

  dynamic "vpc" {
    for_each = var.vpc_id != null ? [var.vpc_id] : []
    content {
      vpc_id = var.vpc_id
    }
  }
}

output "zone_id" {
  value = aws_route53_zone.zone.zone_id
}
