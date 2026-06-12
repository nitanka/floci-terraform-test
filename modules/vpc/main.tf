data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  count = var.create_vpc ? 1 : 0

  cidr_block = var.cidr

  tags = merge(var.tags, { Name = "main" })
}

resource "aws_internet_gateway" "main" {
  count = var.create_vpc && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main[0].id

  tags = merge(var.tags, { Name = "main-igw" })

  depends_on = [ aws_vpc.main ]
}

resource "aws_subnet" "public" {
  count = var.create_vpc ? length(var.public_subnets) : 0

  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = length(var.availability_zones) > 0 ? var.availability_zones[count.index % length(var.availability_zones)] : data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
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

  vpc_id                  = aws_vpc.main[0].id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = length(var.availability_zones) > 0 ? var.availability_zones[count.index % length(var.availability_zones)] : data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  #map_public_ip_on_launch = true

  tags = merge(var.tags, var.private_subnet_tags, {
    Name = "private-${count.index}"
  })
}

resource "aws_route_table" "private" {
  count = var.create_vpc && length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main[0].id

  tags = merge(var.tags, var.private_route_table_tags, { Name = "private-rt" })
}

resource "aws_route_table_association" "private" {
  count = var.create_vpc ? length(var.private_subnets) : 0

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id

  timeouts {
    create = "5m"
  }

  lifecycle {
    ignore_changes = all
  }
}