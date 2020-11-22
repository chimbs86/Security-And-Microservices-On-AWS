resource "aws_vpc" "production_marketing" {
  cidr_block = var.cidr_vpc
  instance_tenancy = "default"

  tags = {
    Name = var.name
  }
}


resource "aws_subnet" "production_customer_a" {
  vpc_id = aws_vpc.production_marketing.id
  cidr_block = var.cidr_subnet
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_name
  }
}


module "ec2" {
  source = "../../../lib/ec2"
  subnet_id = aws_subnet.production_customer_a.id
  vpc_id = aws_vpc.production_marketing.id
}