# Backend generation disabled (see terragrunt.hcl — no remote_state block).
# This unit uses local state.
#
# terraform {
#   backend "s3" {
#     bucket         = "floci-tfstate-local"
#     dynamodb_table = "floci-tf-locks"
#     encrypt        = true
#     endpoints = {
#       dynamodb = "http://localhost:4566"
#       s3       = "http://localhost:4566"
#     }
#     force_path_style            = true
#     key                         = "cdn/terraform.tfstate"
#     region                      = "us-east-1"
#     skip_credentials_validation = true
#     skip_metadata_api_check     = true
#     skip_region_validation      = true
#     skip_requesting_account_id  = true
#   }
# }
