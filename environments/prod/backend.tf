# Remote state (strongly recommended for prod).
# 1. Create an S3 bucket (versioning on) and a DynamoDB table with a "LockID" string key.
# 2. Uncomment the block below and run: terraform init -migrate-state
#
# terraform {
#   backend "s3" {
#     bucket         = "YOUR-TF-STATE-BUCKET"
#     key            = "ecommerce/prod/terraform.tfstate"
#     region         = "eu-west-2"
#     dynamodb_table = "YOUR-TF-LOCK-TABLE"
#     encrypt        = true
#   }
# }
