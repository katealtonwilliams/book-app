terraform {
  backend "s3" {
    bucket         = var.dev_state_lock_bucket
    key            = "terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = var.state_lock_table
    encrypt        = true
  }
}