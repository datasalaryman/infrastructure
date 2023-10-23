terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "datasalaryman-tfstate"
    key    = "prod/prod.tfstate"
    region = "ap-southeast-1"
  }
}

provider "aws" {
  region = "ap-southeast-1"
  #  uncomment if on another machine with another default
  #  AWS account
  #  profile = "personal"
}

module "divcenter_zone" {
  source = "./modules/low-level/route53-zone"
  name = "divcenter.xyz"
}

module "divcenter_routes" {
  source = "./modules/low-level/route53-route"
  zone_id = module.divcenter_zone.zone_id
  record_file = "divcenter.json"
}

module "master_key_pairs" {
  source = "./modules/low-level/key-pair"
  key_name_prefix = "master_key_"
  public_keys_file = "./src/keys/master.pub"
}

