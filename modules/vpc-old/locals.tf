data "aws_availability_zones" "available" {
  state = "available"
}

locals {

  vpc_count = var.create_vpc ? 1 : 0
  
  azs = length(var.availability_zones) > 0 ? var.availability_zones : data.aws_availability_zones.available.names

  # Number of NAT gateways to create based on selected mode
  nat_gateway_count = !var.enable_nat_gateway || length(var.public_subnets) == 0 ? 0 : (
    var.single-nat     ? 1 :
    var.per-az-nat     ? length(local.azs) :
    var.per-subnet-nat ? length(var.private_subnets) :
    1
  )

  # Number of private route tables — one per NAT GW when NAT is enabled, else one shared
  private_rt_count = var.create_vpc && length(var.private_subnets) > 0 ? (
    local.nat_gateway_count > 0 ? local.nat_gateway_count : 1
  ) : 0

  # For each private subnet, which route table index it should use
  # single-nat:     all subnets → rt[0]
  # per-az-nat:     each subnet → rt[az_index]
  # per-subnet-nat: each subnet → rt[subnet_index]
  private_subnet_rt_index = [
    for i in range(length(var.private_subnets)) :
    var.enable_nat_gateway && var.per-az-nat     ? i % length(local.azs) :
    var.enable_nat_gateway && var.per-subnet-nat ? i :
    0
  ]
}