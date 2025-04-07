# maybe put this into dynamo like on cs?
terraform {
  backend "s3" {
    bucket  = "terraform-state"
    region  = "eu-west-2"
    key     = "s3-github-actions/terraform.tfstate"
    encrypt = true
  }
  required_version = ">=1.6.1"
  required_providers {
    aws = {
      version = ">= 5.43.0"
      source  = "hashicorp/aws"
    }
  }
}

