resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  instance_tenancy = "default"

  tags = {
    Name = var.name
  }
}


resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet
  availability_zone = "us-east-1a"

  tags = {
    Name = var.subnet_name
  }
}


module "ec2" {
  source = "../../../lib/ec2"
  subnet_id = aws_subnet.subnet.id
  vpc_id = aws_vpc.vpc.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "production_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }



}
resource "aws_main_route_table_association" "main_table_prod"{
  route_table_id = aws_route_table.production_route.id
  vpc_id = aws_vpc.vpc.id
}