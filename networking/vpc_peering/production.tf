
resource "aws_vpc" "production" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production"
  }
}



resource "aws_subnet" "production_customer" {
  vpc_id     = aws_vpc.production.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "production"
  }
}

resource "aws_vpc_peering_connection" "dev_prod_peering_connection" {
  peer_vpc_id   = aws_vpc.production.id
  vpc_id        = aws_vpc.development.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between production and development"
  }
}

resource "aws_vpc_peering_connection" "shared_prod_peering_connection" {
  peer_vpc_id   = aws_vpc.production.id
  vpc_id        = aws_vpc.shared.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between production and development"
  }
}

resource "aws_route_table" "production_route" {
  vpc_id = aws_vpc.production.id
  tags = {
    Name = "Production Route Table"
  }
  route {
    cidr_block = "10.2.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.dev_prod_peering_connection.id
  }
  route {
    cidr_block = "10.3.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.shared_prod_peering_connection.id
  }

}