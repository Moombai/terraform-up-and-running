terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  # not configured with the backend as we're just experimenting for now
  # backend "s3" {
  #   key = "stage/services/webserver-cluster/terraform.tfstate"
  # }
}

provider "aws" {
  region = "us-east-2"
}

module "users" {
  source = "../../modules/landing-zone/iam-user"

  for_each  = toset(var.user_names)
  user_name = each.value
}

output "user_arns" {
  value       = values(module.users)[*].user_arn
  description = "The ARNs of the created IAM users"
}
