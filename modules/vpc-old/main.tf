
resource "aws_vpc" "main" {
  count = local.vpc_count

  cidr_block = var.cidr

  tags = merge(var.tags, { Name = "main" })
}

resource "aws_internet_gateway" "main" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main[0].id

  tags = merge(var.tags, { Name = "main-igw" })

  depends_on = [aws_vpc.main]
}

resource "aws_subnet" "public" {
  count = var.create_vpc ? length(var.public_subnets) : 0

  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = local.azs[count.index % length(local.azs)]
  map_public_ip_on_launch = true

  tags = merge(var.tags, var.public_subnet_tags, {
    Name = "public-${count.index}"
  })
}

resource "aws_route_table" "public" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }

  tags = merge(var.tags, var.public_route_table_tags, { Name = "public-rt" })
}

resource "aws_route_table_association" "public" {
  count = var.create_vpc ? length(var.public_subnets) : 0

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id

  timeouts {
    create = "5m"
  }

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_subnet" "private" {
  count = var.create_vpc ? length(var.private_subnets) : 0

  vpc_id            = aws_vpc.main[0].id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = local.azs[count.index % length(local.azs)]

  tags = merge(var.tags, var.private_subnet_tags, {
    Name = "private-${count.index}"
  })
}

# One EIP per NAT gateway
resource "aws_eip" "nat" {
  count  = var.create_vpc ? local.nat_gateway_count : 0
  domain = "vpc"

  tags = merge(var.tags, var.aws_eip_tags, { Name = "nat-eip-${count.index}" })
  depends_on = [ vpc ]
}

# NAT gateways placed in public subnets, distributed across AZs
resource "aws_nat_gateway" "main" {
  count = var.create_vpc ? local.nat_gateway_count : 0

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index % length(var.public_subnets)].id

  tags = merge(var.tags, var.aws_nat_gateway_tags, { Name = "nat-${count.index}" })

  depends_on = [aws_internet_gateway.main]
}

# One private route table per NAT gateway (or one shared if NAT is disabled)
resource "aws_route_table" "private" {
  count = var.create_vpc ? local.private_rt_count : 0

  vpc_id = aws_vpc.main[0].id

  tags = merge(var.tags, var.private_route_table_tags, { Name = "private-rt-${count.index}" })
}

# Default route via NAT for each private route table
resource "aws_route" "private_nat" {
  count = var.create_vpc ? local.nat_gateway_count : 0

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[count.index].id
}

resource "aws_route_table_association" "private" {
  count = var.create_vpc ? length(var.private_subnets) : 0

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[local.private_subnet_rt_index[count.index]].id

  timeouts {
    create = "5m"
  }

  lifecycle {
    ignore_changes = all
  }
}
