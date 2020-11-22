resource "aws_vpc" "marketing" {
  cidr_block = var.marketing_vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = var.marketing_vpc_name
  }
}

resource "aws_subnet" "marketing_subnet1" {
  availability_zone = var.default_az
  vpc_id = aws_vpc.marketing.id
  cidr_block = var.marketing_subnet_cidr
  tags = {
    Name = var.marketing_subnet_name
  }
}
output "marketing_vpc_id" {
  value = aws_vpc.marketing.id
}
output "marketing_subnet_id" {
  value = aws_subnet.marketing_subnet1.id
}

module "ec2_marketing_test" {
  count = var.ec2_inside_each
  source = "../ec2"
  subnet_id = aws_subnet.marketing_subnet1.id
  vpc_id = aws_vpc.marketing.id
}