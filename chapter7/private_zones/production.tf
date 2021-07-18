module "vpc_structure" {
  source = "../../lib/vpc_structure"
  customer_subnet_cidr = local.customer.customer_subnet_cidr
  customer_vpc_cidr = local.customer.customer_vpc_cidr
  finance_subnet_cidr = local.finance.finance_subnet_cidr
  finance_vpc_cidr = local.finance.finance_vpc_cidr
  marketing_subnet_cidr = local.marketing.marketing_subnet_cidr
  marketing_vpc_cidr = local.marketing.marketing_vpc_cidr
  ec2_inside_each = 0
}

module "ec2_customer" {
  source = "../../lib/ec2"
  route_table_id = module.vpc_structure.customer_route_table_id
  subnet_id = module.vpc_structure.customer_subnet_id
  vpc_id = module.vpc_structure.customer_vpc_id
  vpc_name = "customer"
}

module "ec2_customer2" {
  source = "../../lib/ec2"
  route_table_id = module.vpc_structure.marketing_route_table_id
  subnet_id = module.vpc_structure.marketing_subnet_id
  vpc_id = module.vpc_structure.marketing_vpc_id
  vpc_name = "marketing"
}

resource "aws_route53_zone" "private" {
  name = "google.com"


  vpc {
    vpc_id = module.vpc_structure.marketing_vpc_id
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.id
  name = "google.com"
  type = "A"
  ttl = "5"
  records = [module.ec2_customer.ip]
}