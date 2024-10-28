# configure the s3 bucket to use for the backend

bucket = "terraform-up-and-running-state-27102024"
region = "us-east-2"

# configure the dynamodb table for state locking

dynamodb_table = "terraform-up-and-running-locks-27102024"
encrypt = true
