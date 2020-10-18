resource "aws_vpc" "shared" {
  cidr_block       = "10.3.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "shared"
  }
}

resource "aws_subnet" "logging" {
  vpc_id     = aws_vpc.shared.id
  cidr_block = "10.3.1.0/24"

  tags = {
    Name = "shared"
  }
}