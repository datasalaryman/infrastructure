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

module "master_key_pairs" {
  source = "./modules/low-level/key-pair"
  key_name_prefix = "master_key_"
  public_keys_file = "./src/keys/master.pub"
}

