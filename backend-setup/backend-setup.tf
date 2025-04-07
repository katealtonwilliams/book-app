provider "aws" {
  region                   = "eu-west-2"
  shared_credentials_files = ["/home/kate/.aws/credentials"]
}

resource "aws_s3_bucket" "dev_tf_state" {
  bucket = "terraform-state-bucket-aebb0499259047588b07a8b0382e8026"
}

resource "aws_s3_bucket_ownership_controls" "dev_tf_state" {
  bucket = aws_s3_bucket.dev_tf_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dev_tf_state" {
  depends_on = [aws_s3_bucket_ownership_controls.dev_tf_state]

  bucket = aws_s3_bucket.dev_tf_state.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "dev_tf_state" {
  bucket = aws_s3_bucket.dev_tf_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "dev_tf_state_versioning" {
  bucket = aws_s3_bucket.dev_tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  enable_key_rotation     = true
  deletion_window_in_days = 7
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dev_tf_state" {
  bucket = aws_s3_bucket.dev_tf_state.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}