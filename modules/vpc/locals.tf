data "aws_availability_zones" "available" {
  state = "available"
}

locals {
    azs = length(var.availability_zones) > 0 ? var.availability_zones : data.aws_availability_zones.available.names

    nat_gateway_count = !var.enable_nat_gateway || length(var.public_subnets) == 0 ? 0 : (
        var.single_nat     ? 1 :
        var.per_az_nat     ? length(local.azs) :
        var.per_subnet_nat ? length(var.private_subnets) :
        1
    )
    private_rt_count = length(var.private_subnets) > 0 ? (
        local.nat_gateway_count > 0 ? local.nat_gateway_count : 1
    ) : 0
    common_tags = merge(
        {
            ManagedBy = "Terraform"
            Module    = "vpc"
        },
        var.tags
    )
}