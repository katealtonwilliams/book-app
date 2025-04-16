provider "aws" {
  region = "eu-west-2"
}

terraform {
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.43.0"
    }
  }
}

resource "aws_s3_bucket" "state_bucket" {
  #checkov:skip=CKV_AWS_145: Lifecycle configuration not required for TF state bucket
  #checkov:skip=CKV2_AWS_61: Lifecycle configuration not required for TF state bucket
  #checkov:skip=CKV_AWS_144: Cross-region replication not required for TF state bucket
  #checkov:skip=CKV2_AWS_62: Event notifications not required for TF state bucket
  #checkov:skip=CKV_AWS_145: No KMS encryption needed for TF state bucket
  #checkov:skip=CKV_AWS_21: No versioning needed for TF state bucket
  #checkov:skip=CKV_AWS_18: No logging needed for TF state bucket
  bucket = var.state_bucket
}

resource "aws_s3_bucket_server_side_encryption_configuration" "state_bucket_encryption" {
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "state_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.state_bucket_acl_ownership]
  bucket     = aws_s3_bucket.state_bucket.id
  acl        = "private"
}

resource "aws_s3_bucket_ownership_controls" "state_bucket_acl_ownership" {
  #checkov:skip=CKV2_AWS_65:Check if this is needed
  bucket = aws_s3_bucket.state_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_versioning" "state_bucket_version" {
  bucket = aws_s3_bucket.state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_object" "terraform_folder" {
  bucket = aws_s3_bucket.state_bucket.id
  key    = "terraform.tfstate"
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_access" {

  bucket                  = aws_s3_bucket.state_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_dynamodb_table" "dynamodb_tfstate_lock" {
  #checkov:skip=CKV2_AWS_16: Auto Scaling not required for TF state bucket
  #checkov:skip=CKV_AWS_28: Dynamodb point in time recovery not required for TF state bucket
  #checkov:skip=CKV_AWS_119: KMS Customer Managed CMK not required for TF state bucket

  name           = var.state_table
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

}