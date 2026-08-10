output "peering_connection_id" {
  description = "The VPC peering connection ID"
  value       = aws_vpc_peering_connection.ap_south_1_to_us_east_1.id
}

output "accepter_status" {
  description = "Status of the peering connection accepter"
  value       = aws_vpc_peering_connection_accepter.us_east_1_accepts_ap_south_1.accept_status
}
