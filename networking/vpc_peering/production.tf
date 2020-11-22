module "vpc_structure" {
  source = "../../lib/vpc_structure"




  customer_subnet_cidr = local.customer.customer_subnet_cidr
  customer_vpc_cidr = local.customer.customer_vpc_cidr
  finance_subnet_cidr = local.finance.finance_subnet_cidr
  finance_vpc_cidr = local.finance.finance_vpc_cidr
  marketing_subnet_cidr = local.marketing.marketing_subnet_cidr
  marketing_vpc_cidr = local.marketing.marketing_vpc_cidr
}


resource "aws_vpc_peering_connection" "customer_finance_peering_connection" {
  peer_vpc_id = module.vpc_structure.customer_vpc_id
  vpc_id = module.vpc_structure.finance_vpc_id
  auto_accept = true

  tags = {
    Name = "VPC Peering between production and development"
  }
}

resource "aws_vpc_peering_connection" "marketing_finance_peering_connection" {
  peer_vpc_id = module.vpc_structure.marketing_vpc_id
  vpc_id = module.vpc_structure.finance_vpc_id
  auto_accept = true

  tags = {
    Name = "VPC Peering between production and development"
  }
}

resource "aws_route_table" "finance_route" {
  vpc_id = module.vpc_structure.finance_vpc_id
  tags = {
    Name = "Production Route Table"
  }
  route {
    cidr_block = local.marketing.marketing_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.marketing_finance_peering_connection.id
  }
  route {
    cidr_block = local.customer.customer_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.customer_finance_peering_connection.id
  }


}
resource "aws_main_route_table_association" "main_table_prod" {
  route_table_id = aws_route_table.finance_route.id
  vpc_id = module.vpc_structure.finance_vpc_id
}


resource "aws_route_table" "customer_route" {
  vpc_id = module.vpc_structure.customer_vpc_id
  tags = {
    Name = "Customer Route Table"
  }
  route {
    cidr_block = local.finance.finance_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.customer_finance_peering_connection.id
  }



}
resource "aws_main_route_table_association" "main_table_customer" {
  route_table_id = aws_route_table.customer_route.id
  vpc_id = module.vpc_structure.customer_vpc_id
}


resource "aws_route_table" "marketing_route" {
  vpc_id = module.vpc_structure.marketing_vpc_id
  tags = {
    Name = "marketing Route Table"
  }
  route {
    cidr_block = local.finance.finance_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.marketing_finance_peering_connection.id
  }



}
resource "aws_main_route_table_association" "main_table_prod" {
  route_table_id = aws_route_table.marketing_route.id
  vpc_id = module.vpc_structure.marketing_vpc_id
}