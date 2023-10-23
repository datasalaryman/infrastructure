provider "aws" {
  region = "ap-southeast-1"
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

variable "domain_name" {
  type = string
  description = "domain to provision an ssl certificate"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = "${var.domain_name}"
  validation_method = "DNS"
  subject_alternative_names = ["*.${var.domain_name}", "${var.domain_name}"]
  lifecycle {
    create_before_destroy = true
  }
}