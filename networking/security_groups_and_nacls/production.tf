resource "aws_vpc" "production_customer" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production_customer"
  }
}


resource "aws_subnet" "production_customer_a" {
  vpc_id = aws_vpc.production_customer.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "production_customer"
  }
}


resource "aws_subnet" "production_customer_b" {
  vpc_id = aws_vpc.production_customer.id
  cidr_block = "10.1.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "production_customer"
  }
}



resource "aws_subnet" "production_customer_c" {
  vpc_id = aws_vpc.production_customer.id
  cidr_block = "10.1.3.0/24"

  tags = {
    Name = "production_customer"
  }
}




resource "aws_subnet" "production_customer_d" {
  vpc_id = aws_vpc.production_customer.id
  cidr_block = "10.1.4.0/24"

  tags = {
    Name = "production_customer"
  }
}



