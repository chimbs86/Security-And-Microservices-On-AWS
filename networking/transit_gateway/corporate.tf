resource "aws_vpc" "corporate" {
  cidr_block       = "10.4.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "corporate"
  }
}

resource "aws_subnet" "corporate_email" {
  vpc_id     = aws_vpc.corporate.id
  cidr_block = "10.4.1.0/24"

  tags = {
    Name = "corporate"
  }
}