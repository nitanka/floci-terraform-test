output "vpc_id" {
  description = "The ID of the VPC."
  value       = var.create_vpc ? aws_vpc.main[0].id : null
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets."
  value       = aws_subnet.private[*].id
}

output "public_route_table_id" {
  description = "ID of the public route table."
  value       = length(aws_route_table.public) > 0 ? aws_route_table.public[0].id : null
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = length(aws_internet_gateway.main) > 0 ? aws_internet_gateway.main[0].id : null
}
