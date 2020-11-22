resource "aws_vpc" "finance" {
  cidr_block       = var.finance_vpc_cidr
  instance_tenancy = "default"
}

resource "aws_subnet" "finance" {
  availability_zone = var.default_az
  vpc_id     = aws_vpc.finance.id
  cidr_block = var.finance_subnet_cidr
}

output "finance_vpc_id" {
  value = aws_vpc.finance.id
}