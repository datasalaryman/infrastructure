provider "aws" {
  region = "ap-southeast-1"
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

variable "name" {
  type = string
  description = "name of s3 bucket"
}

variable "bucket_owner_control" {
  type = string
  description = "policy controlling bucket ownership, one of `BucketOwnerEnforced`, `BucketOwnerPreferred`, or `ObjectWriter`"
  default = "BucketOwnerEnforced"
}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "${var.name}-"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "owner_policy" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = var.bucket_owner_control
  }
}

output "bucket_name" {
  value = "${aws_s3_bucket.bucket.id}"
}



