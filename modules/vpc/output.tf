output "vpc_id" {
  description = "The ID of the VPC."
  value       = var.create_vpc ? aws_vpc.main[0].id : null
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets."
  value       = aws_subnet.public[*].id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = length(aws_internet_gateway.main) > 0 ? aws_internet_gateway.main[0].id : null
}
