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

module "peering_routes_finance_marketing" {
  source = "../../lib/peering_connection_module"
  acceptor_cidr_block = local.marketing.marketing_vpc_cidr
  main_cidr_block = local.finance.finance_vpc_cidr
  peering_connection_id = aws_vpc_peering_connection.marketing_finance_peering_connection.id
  route_table_acceptor_id = module.vpc_structure.finance_route_table_id
  route_table_main_id = module.vpc_structure.marketing_route_table_id
}
module "peering_routes_finance_customer" {

  source = "../../lib/peering_connection_module"
  acceptor_cidr_block = local.customer.customer_vpc_cidr
  main_cidr_block = local.finance.finance_vpc_cidr
  peering_connection_id = aws_vpc_peering_connection.customer_finance_peering_connection.id
  route_table_acceptor_id = module.vpc_structure.finance_route_table_id
  route_table_main_id = module.vpc_structure.customer_route_table_id
}