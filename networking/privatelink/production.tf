resource "aws_vpc" "production_customer" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production_customer"
  }
}


resource "aws_subnet" "production_customer_a" {
  vpc_id = aws_vpc.production_customer.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "production_customer"
  }
}


resource "aws_vpc" "production_marketing" {
  cidr_block = "10.4.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production_marketing"
  }
}


resource "aws_subnet" "production_marketing_a" {
  vpc_id = aws_vpc.production_marketing.id
  cidr_block = "10.4.1.0/24"

  tags = {
    Name = "production_marketing"
  }
}


resource "aws_vpc" "production_finance" {
  cidr_block = "10.5.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production_finance"
  }
}


resource "aws_subnet" "production_finance_a" {
  vpc_id = aws_vpc.production_finance.id
  cidr_block = "10.5.1.0/24"

  tags = {
    Name = "production_finance"
  }
}


resource "aws_lb" "customer_account_total" {
  name = "balance-service-loadbalancer"
  #can also be obtained from the variable nlb_config
  load_balancer_type = "network"
  internal = true
  subnet_mapping {
    subnet_id = aws_subnet.production_finance_a.id
  }
  tags = {
    Environment = "prod"
  }
}

resource "aws_vpc_endpoint_service" "balance_service_endpoint_service" {
  acceptance_required = false
  network_load_balancer_arns = [
    aws_lb.customer_account_total.arn]
}

resource "aws_vpc_endpoint_subnet_association" "sn_ec2" {
  vpc_endpoint_id = aws_vpc_endpoint.balance_service_endpoint.id
  subnet_id = aws_subnet.production_finance_a.id
}

resource "aws_vpc_endpoint" "balance_service_endpoint" {
  vpc_id = aws_vpc.production_finance.id
  service_name = aws_vpc_endpoint_service.balance_service_endpoint_service.service_name
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_default_security_group.default.id]

}


resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.production_finance.id

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