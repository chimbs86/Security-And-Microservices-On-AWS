resource "aws_vpc" "development" {
  cidr_block       = "10.2.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "development"
  }
}


resource "aws_subnet" "development_customer" {
  vpc_id     = aws_vpc.development.id
  cidr_block = "10.2.1.0/24"

  tags = {
    Name = "development"
  }
}

resource "aws_vpc_peering_connection" "dev_shared_peering" {
  peer_vpc_id = aws_vpc.shared.id
  vpc_id = aws_vpc.development.id
  auto_accept = true

  tags = {
    Name = "VPC Peering between production and development"
  }
}
resource "aws_route_table" "development_routeTable" {
  vpc_id = aws_vpc.development.id
  tags = {
    Name = "Development Route Table"
  }
  route {
    cidr_block = "10.3.0.0/16"
    vpc_peering_connection_id = aws_vpc_peering_connection.dev_shared_peering.id
  }

}