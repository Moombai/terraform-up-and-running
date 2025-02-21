provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "prod/data-stores/mysql/terraform.tfstate"
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "terraform-up-and-running"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  # we'll probably get a name clash unless we use a unique db_name
  db_name = "example_database"

  username = var.db_username
  password = var.db_password
}
