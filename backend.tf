terraform {
  required_version = ">= 1.6.1"

  backend "s3" {
    bucket         = "terraform-state-bucket-aebb0499259047588b07a8b0382e8026"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.43.0"
    }
  }
}

