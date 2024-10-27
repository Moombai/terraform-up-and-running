provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    # configure the s3 bucket to use for the backend
    bucket = "terraform-up-and-running-state-27102024"
    key    = "global/s3/terraform.tfstate"
    region = "us-east-2"

    # configure the dynamodb table for state locking
    dynamodb_table = "terraform-up-and-running-locks-27102024"
    encrypt        = true
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-up-and-running-state-27102024"

  # prevent accidental deletion
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ! To use DynamoDB as a lock table, you need to create a DynamoDB table
# with a primary key named LockID.
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks-27102024"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
