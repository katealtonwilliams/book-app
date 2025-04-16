provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket         = "terraform_state_c76b7076-4949-4ddc-830f-bb61d5fb43fe"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform_state_lock"
    encrypt        = true
  }
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43.0"
    }
  }
}

