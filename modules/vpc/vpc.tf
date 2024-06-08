resource "aws_vpc" "my_vpc" {
  count                = var.enable_vpc ? 1 : 0
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
}

resource "aws_subnet" "public_subnet" {
  count      = var.enable_vpc ? 1 : 0
  vpc_id     = aws_vpc.my_vpc[0].id
  cidr_block = var.public_cidr_block
  tags = {
    type = "public"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = var.enable_vpc ? 1 : 0
  vpc_id                  = aws_vpc.my_vpc[0].id
  cidr_block              = var.private_cidr_block
  map_public_ip_on_launch = true
  tags = {
    type = "private"
  }
}

resource "aws_internet_gateway" "my_gw" {
  count  = var.enable_vpc ? 1 : 0
  vpc_id = aws_vpc.my_vpc[0].id
  tags = {
    Name = "my-gw"
  }
}

resource "aws_nat_gateway" "my_ngw" {
  count         = var.enable_vpc ? 1 : 0
  depends_on    = [aws_internet_gateway.my_gw[0]]
  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public_subnet[0].id
  tags = {
    Name = "gw NAT"
  }
}

resource "aws_eip" "nat" {
  count  = var.enable_vpc ? 1 : 0
  domain = "vpc"
}

resource "aws_route_table" "public" {
  count  = var.enable_vpc ? 1 : 0
  vpc_id = aws_vpc.my_vpc[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gw[0].id
  }

  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table" "private" {
  count  = var.enable_vpc ? 1 : 0
  vpc_id = aws_vpc.my_vpc[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_ngw[0].id
  }

  route {
    cidr_block = var.cidr_block
    gateway_id = "local"
  }

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.enable_vpc ? 1 : 0
  subnet_id      = aws_subnet.public_subnet[0].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route_table_association" "private" {
  count          = var.enable_vpc ? 1 : 0
  subnet_id      = aws_subnet.private_subnet[0].id
  route_table_id = aws_route_table.private[0].id
}

resource "aws_security_group" "my_sg" {
  count       = var.enable_vpc ? 1 : 0
  name        = "allow_some_ports"
  description = "Allow ssh and http inbound traffic"
  vpc_id      = aws_vpc.my_vpc[0].id

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}


