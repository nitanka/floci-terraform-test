# No `include "root"` here — root's generate "provider" block would collide
# with this unit's own (Terragrunt errors on duplicate generate labels, it
# does not let a child override a same-named parent block). This unit owns
# its own remote_state and provider generation entirely.
remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "floci-tfstate-local"
    key    = "peering/terraform.tfstate"
    region = "us-east-1"

    encrypt        = true
    dynamodb_table = "floci-tf-locks"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_bucket_versioning      = true
    force_path_style            = true

    endpoints = {
      s3       = "http://localhost:4566"
      dynamodb = "http://localhost:4566"
    }
  }
}

dependency "ap_south_1" {
  config_path = "../ap-south-1"

  # Fake values used only for plan/validate before ap-south-1 has been
  # applied. Real apply always requires the actual state/outputs below.
  mock_outputs = {
    vpc_id                  = "vpc-mock"
    vpc_cidr_block          = "10.0.0.0/16"
    public_route_table_ids  = ["rtb-mock"]
    private_route_table_ids = ["rtb-mock"]
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

dependency "us_east_1" {
  config_path = "../us-east-1"

  mock_outputs = {
    vpc_id                  = "vpc-mock"
    vpc_cidr_block          = "10.1.0.0/16"
    public_route_table_ids  = ["rtb-mock"]
    private_route_table_ids = ["rtb-mock"]
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

# dependency.*.outputs.* is only valid here in terragrunt.hcl — this maps
# those outputs onto plain Terraform variables that main.tf can reference.
inputs = {
  ap_south_1_vpc_id                  = dependency.ap_south_1.outputs.vpc_id
  ap_south_1_cidr_block               = dependency.ap_south_1.outputs.vpc_cidr_block
  ap_south_1_public_route_table_ids   = dependency.ap_south_1.outputs.public_route_table_ids
  ap_south_1_private_route_table_ids  = dependency.ap_south_1.outputs.private_route_table_ids

  us_east_1_vpc_id                  = dependency.us_east_1.outputs.vpc_id
  us_east_1_cidr_block               = dependency.us_east_1.outputs.vpc_cidr_block
  us_east_1_public_route_table_ids   = dependency.us_east_1.outputs.public_route_table_ids
  us_east_1_private_route_table_ids  = dependency.us_east_1.outputs.private_route_table_ids
}

# Two aliased providers, since this unit creates/accepts a peering
# connection across both regions in one apply.
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
  alias                       = "ap_south_1"
  region                      = "ap-south-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2 = "http://localhost:4566"
  }
}

provider "aws" {
  alias                       = "us_east_1"
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    ec2 = "http://localhost:4566"
  }
}
EOF
}
