resource "aws_vpc" "finance" {
  cidr_block       = var.finance_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.finance_vpc_name
  }
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "finance" {
  availability_zone = var.default_az
  vpc_id     = aws_vpc.finance.id
  cidr_block = var.finance_subnet_cidr
  tags = {
    Name = var.finance_subnet_name
  }
}

output "finance_vpc_id" {
  value = aws_vpc.finance.id
}

output "finance_subnet_id" {
  value = aws_subnet.finance.id
}


resource "aws_route_table" "finance_route_table" {
  vpc_id = aws_vpc.finance.id
}

output "finance_route_table_id" {
  value = aws_route_table.finance_route_table.id
}

module "ec2_finance" {
  count = var.ec2_inside_each
  source = "../ec2"
  subnet_id = aws_subnet.finance.id
  vpc_id = aws_vpc.finance.id
  route_table_id = aws_route_table.finance_route_table.id
  vpc_name = aws_vpc.finance.tags.Name
}