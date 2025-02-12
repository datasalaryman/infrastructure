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

module "dev_environment" {
  source = "./modules/low-level/ec2"
  instance_name = "endrinal_dev"
  ami = "ami-051557d87f0e75fff"
  type = "r7g.large"
  key_pair = module.master_key_pairs.key_pair_names[0]
}

