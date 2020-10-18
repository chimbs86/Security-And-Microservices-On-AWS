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