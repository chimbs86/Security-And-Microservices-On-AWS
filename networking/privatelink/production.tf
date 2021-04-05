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

resource "aws_vpc_endpoint_service" "finance_endpoint_privatelink" {
  acceptance_required = false
  network_load_balancer_arns = [
    aws_lb.finance_service_loadbalancer.arn]
}

resource "aws_vpc_endpoint_subnet_association" "sn_ec2" {
  vpc_endpoint_id = aws_vpc_endpoint.balance_service_endpoint.id
  subnet_id = module.vpc_structure.customer_subnet_id
}

resource "aws_vpc_endpoint" "balance_service_endpoint" {
  vpc_id = module.vpc_structure.customer_vpc_id
  service_name = aws_vpc_endpoint_service.finance_endpoint_privatelink.service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_default_security_group.default.id]

}


resource "aws_default_security_group" "default" {
  vpc_id = module.vpc_structure.customer_vpc_id

  ingress {
    protocol = -1
    self = true
    from_port = 0
    to_port = 0
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}
