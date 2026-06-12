module "vpc" {
  source = "../../modules/vpc"

  create_vpc = var.create_vpc
  cidr       = var.cidr

  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets

  public_subnet_tags      = var.public_subnet_tags
  public_route_table_tags = var.public_route_table_tags
  private_subnet_tags = var.private_subnet_tags
  private_route_table_tags = var.private_route_table_tags

  tags = var.tags
}
