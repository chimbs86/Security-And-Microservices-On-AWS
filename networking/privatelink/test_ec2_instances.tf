module "ec2_finance" {
  source = "../../lib/ec2"
  route_table_id = module.vpc_structure.finance_route_table_id
  subnet_id = module.vpc_structure.finance_subnet_id
  vpc_id = module.vpc_structure.finance_vpc_id
  vpc_name = "finance"
}

module "ec2_customer" {
  source = "../../lib/ec2"
  route_table_id = module.vpc_structure.customer_route_table_id
  subnet_id = module.vpc_structure.customer_subnet_id
  vpc_id = module.vpc_structure.customer_vpc_id
  vpc_name = "customer"
}
