
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

//resource "aws_vpc_peering_connection" "foo" {
//  peer_vpc_id   = aws_vpc.production.id
//  vpc_id        = aws_vpc.development.id
//  auto_accept   = true
//
//  tags = {
//    Name = "VPC Peering between foo and bar"
//  }
//}