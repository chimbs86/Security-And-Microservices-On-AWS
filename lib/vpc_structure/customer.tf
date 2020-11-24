resource "aws_vpc" "customer" {
  cidr_block       = var.customer_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.customer_vpc_name
  }
  enable_dns_hostnames = true
  enable_dns_support = true
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
resource "aws_route_table" "customer_route_table" {
  vpc_id = aws_vpc.customer.id
}

output "customer_route_table_id" {
  value = aws_route_table.customer_route_table.id
}

module "ec2_customer_test" {
  count = var.ec2_inside_each
  source = "../ec2"
  subnet_id = aws_subnet.customer_subnet.id
  vpc_id = aws_vpc.customer.id
  route_table_id = aws_route_table.customer_route_table.id
  vpc_name = aws_vpc.customer.tags.Name
}