output "vpc_id" {
    description = "The ID of the VPC"
    value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
    description = "The CIDR block of the VPC"
    value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
    description = "List of IDs of public subnets"
    value       = module.vpc.public_subnets
}

output "private_subnets" {
    description = "List of IDs of private subnets"
    value       = module.vpc.private_subnets
}

output "igw_id" {
    description = "The ID of the Internet Gateway"
    value       = module.vpc.igw_id
}

output "natgw_ids" {
    description = "List of NAT Gateway IDs"
    value       = module.vpc.natgw_ids
}

output "public_route_table_ids" {
    description = "List of IDs of public route tables"
    value       = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
    description = "List of IDs of private route tables"
    value       = module.vpc.private_route_table_ids
}
