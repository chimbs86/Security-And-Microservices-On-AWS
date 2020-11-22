resource "aws_vpc" "finance" {
  cidr_block       = var.finance_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.finance_vpc_name
  }
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