module "vpc" {
  source = "../../modules/vpc"

  name = var.name
  cidr = var.cidr
  tags = var.tags

  availability_zones = var.availability_zones
  public_subnets      = var.public_subnets
  private_subnets     = var.private_subnets

  enable_nat_gateway  = var.enable_nat_gateway
  create_igw          = var.create_igw
  single_nat_gateway  = var.single_nat_gateway

  default_security_group_igress_rules = var.default_security_group_igress_rules

  enable_flow_log                      = var.enable_flow_log
  create_flow_log_cloudwatch_iam_role   = var.create_flow_log_cloudwatch_iam_role
  create_flow_log_cloudwatch_log_group  = var.create_flow_log_cloudwatch_log_group
  flow_log_destination_type             = var.flow_log_destination_type
  flow_log_destination_arn              = var.flow_log_destination_arn
  flow_log_file_format                  = var.flow_log_file_format

  manage_default_security_group = var.manage_default_security_group
  manage_default_network_acl    = var.manage_default_network_acl
  manage_default_route_table    = var.manage_default_route_table
}

module "s3" {
  source = "../../modules/s3"

  create_bucket = var.create_bucket
  bucket        = var.bucket
  bucket_prefix = var.bucket_prefix
  region        = var.region
  tags          = var.tags

  logging    = var.logging
  versioning = var.versioning

  lifecycle_rule = var.lifecycle_rule

  replication_configuration            = var.replication_configuration
  enable_replication                   = var.enable_replication
  replica_bucket_arn                   = var.replica_bucket_arn
  server_side_encryption_configuration = var.server_side_encryption_configuration

  attach_policy = var.attach_policy
}

module "ec2" {
  source = "../../modules/ec2"

  create_ec2_instance = var.create_ec2_instance

  name          = var.instance_name
  instance_type = var.instance_type
  monitoring    = var.instance_monitoring

  vpc_id    = module.vpc.vpc_id
  subnet_id = var.instance_subnet_type == "public" ? module.vpc.public_subnets[0] : module.vpc.private_subnets[0]

  user_data = templatefile("${path.module}/scripts/user-data.sh", {
    region = var.region
  })

  tags = var.tags
}
