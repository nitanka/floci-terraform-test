# Values come from ../ap-south-1 and ../us-east-1's actual state, via the
# `dependency` blocks + `inputs` mapping in terragrunt.hcl (see variables.tf
# for the corresponding variable declarations). No hardcoded IDs.

resource "aws_vpc_peering_connection" "ap_south_1_to_us_east_1" {
  provider    = aws.ap_south_1
  vpc_id      = var.ap_south_1_vpc_id
  peer_vpc_id = var.us_east_1_vpc_id
  peer_region = "us-east-1"

  tags = {
    Name = "ap-south-1-to-us-east-1"
  }
}

resource "aws_vpc_peering_connection_accepter" "us_east_1_accepts_ap_south_1" {
  provider                  = aws.us_east_1
  vpc_peering_connection_id = aws_vpc_peering_connection.ap_south_1_to_us_east_1.id
  auto_accept               = true

  tags = {
    Name = "ap-south-1-to-us-east-1"
  }
}

# Routes on the ap-south-1 side, pointing at us-east-1's CIDR
resource "aws_route" "ap_south_1_public_to_us_east_1" {
  provider                  = aws.ap_south_1
  count                     = length(var.ap_south_1_public_route_table_ids)
  route_table_id            = var.ap_south_1_public_route_table_ids[count.index]
  destination_cidr_block    = var.us_east_1_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ap_south_1_to_us_east_1.id
}

resource "aws_route" "ap_south_1_private_to_us_east_1" {
  provider                  = aws.ap_south_1
  count                     = length(var.ap_south_1_private_route_table_ids)
  route_table_id            = var.ap_south_1_private_route_table_ids[count.index]
  destination_cidr_block    = var.us_east_1_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ap_south_1_to_us_east_1.id
}

# Routes on the us-east-1 side, pointing at ap-south-1's CIDR
resource "aws_route" "us_east_1_public_to_ap_south_1" {
  provider                  = aws.us_east_1
  count                     = length(var.us_east_1_public_route_table_ids)
  route_table_id            = var.us_east_1_public_route_table_ids[count.index]
  destination_cidr_block    = var.ap_south_1_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ap_south_1_to_us_east_1.id
}

resource "aws_route" "us_east_1_private_to_ap_south_1" {
  provider                  = aws.us_east_1
  count                     = length(var.us_east_1_private_route_table_ids)
  route_table_id            = var.us_east_1_private_route_table_ids[count.index]
  destination_cidr_block    = var.ap_south_1_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ap_south_1_to_us_east_1.id
}
