resource "aws_vpc" "marketing" {
  cidr_block       = var.marketing_vpc_cidr
  instance_tenancy = "default"
}

resource "aws_subnet" "marketing_subnet1" {
  availability_zone = var.default_az
  vpc_id     = aws_vpc.marketing.id
  cidr_block = var.marketing_subnet_cidr
}
output "marketing_vpc_id" {
  value = aws_vpc.marketing.id
}