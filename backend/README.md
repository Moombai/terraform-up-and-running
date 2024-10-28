# What is this?

The backend config for terraform. Enables us to save our state in AWS using a combination of s3 for storage and dyanamodb for state locking.

## Config

If you ever need to move the config file you'll also need to reinitialize terraform again. To do so run:
`terraform init -backend-config=<path to config file>`

## Delete this backend

1. Go to the Terraform code, remove the backend configuration, and rerun terraform init to copy the Terraform state back to your local disk.
2. Run terraform destroy to delete the S3 bucket and DynamoDB table.
