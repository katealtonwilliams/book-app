terraform {
  backend "s3" {
    bucket         = var.state_bucket
    key            = "terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = var.state_table
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

provider "aws" {
  region = var.aws_region
}