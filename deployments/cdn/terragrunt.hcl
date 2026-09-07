# No `include "root"` here — root's generate "provider" block derives region
# from the directory name (basename(get_terragrunt_dir())), which would give
# "cdn" instead of "ap-south-1". This unit owns its own provider generation
# entirely, same pattern as ../peering. No remote_state block — this unit
# uses local state (no backend.tf generated).

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region                      = "ap-south-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2        = "http://localhost:4566"
    s3         = "http://localhost:4566"
    sts        = "http://localhost:4566"
    iam        = "http://localhost:4566"
    cloudfront = "http://localhost:4566"
  }
}
EOF
}
