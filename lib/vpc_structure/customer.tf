resource "aws_vpc" "customer" {
  cidr_block       = var.customer_vpc_cidr
  instance_tenancy = "default"
}

resource "aws_subnet" "customer_subnet" {
  availability_zone = var.default_az
  vpc_id     = aws_vpc.customer.id
  cidr_block = var.customer_subnet_cidr
}
output "customer_vpc_id" {
  value = aws_vpc.customer.id
}