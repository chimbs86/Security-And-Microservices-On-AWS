resource "aws_ec2_transit_gateway" "example_gateway" {
  description = "Centralized Transit Gateway"
}

module "vpc_structure" {
  source = "../../lib/vpc_structure"
  customer_subnet_cidr = local.customer.customer_subnet_cidr
  customer_vpc_cidr = local.customer.customer_vpc_cidr
  finance_subnet_cidr = local.finance.finance_subnet_cidr
  finance_vpc_cidr = local.finance.finance_vpc_cidr
  marketing_subnet_cidr = local.marketing.marketing_subnet_cidr
  marketing_vpc_cidr = local.marketing.marketing_vpc_cidr
}

resource "aws_ec2_transit_gateway_vpc_attachment" "finance_attachment" {
  subnet_ids = [
    module.vpc_structure.finance_subnet_id]
  transit_gateway_id = aws_ec2_transit_gateway.example_gateway.id
  vpc_id = module.vpc_structure.finance_vpc_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "marketing_attachment" {
  subnet_ids = [
    module.vpc_structure.marketing_subnet_id]
  transit_gateway_id = aws_ec2_transit_gateway.example_gateway.id
  vpc_id = module.vpc_structure.marketing_vpc_id
}

resource "aws_ec2_transit_gateway_vpc_attachment" "customer_attachment" {
  subnet_ids = [
    module.vpc_structure.customer_subnet_id]
  transit_gateway_id = aws_ec2_transit_gateway.example_gateway.id
  vpc_id = module.vpc_structure.customer_vpc_id
}