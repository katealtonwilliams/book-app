# maybe put this into dynamo like on cs?
terraform {
  backend "s3" {
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-lock"
    key            = "terraform-state"
  }
  required_version = ">=1.6.1"
  required_providers {
    aws = {
      version = ">= 5.43.0"
      source  = "hashicorp/aws"
    }
  }
}

