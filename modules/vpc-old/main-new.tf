resource "aws_vpc" "main" {
    tags = merge(var.tags, { Name = "main-new"})

    cidr_block = var.cidr
    azs = local.azs
}   

resource "aws_internet_gateway" "main-rt" {
    vpc_id = aws_vpc.main[0].id
    tags = merge(var.tags, { Name = "main-new-rt"})

    depends_on = [aws_vpc.main]
}

resource "aws_publ" "name" {
  
}