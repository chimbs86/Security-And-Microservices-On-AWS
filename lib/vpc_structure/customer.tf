resource "aws_vpc" "customer" {
  cidr_block       = var.customer_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.customer_vpc_name
  }
}

resource "aws_subnet" "customer_subnet" {
  availability_zone = var.default_az
  vpc_id     = aws_vpc.customer.id
  cidr_block = var.customer_subnet_cidr
  tags = {
    Name = var.customer_subnet_name
  }
}
output "customer_vpc_id" {
  value = aws_vpc.customer.id
}
output "customer_subnet_id" {
  value = aws_subnet.customer_subnet.id
}

module "ec2_customer_test" {
  count = var.ec2_inside_each
  source = "../ec2"
  subnet_id = aws_subnet.customer_subnet.id
  vpc_id = aws_vpc.customer.id
}