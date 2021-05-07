resource "aws_apigatewayv2_api" "p_e" {
  name          = "plaid-exchange"
  protocol_type = "HTTP"

  tags = {
    Pod = "test"
  }
}

resource "aws_vpc" "p_e_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "p_e_subnet" {
  availability_zone = "us-east-1a"
  vpc_id     = aws_vpc.p_e_vpc.id
  cidr_block = "10.0.0.0/24"

}


resource "aws_default_security_group" "default" {
  vpc_id  = aws_vpc.p_e_vpc.id

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


resource "aws_apigatewayv2_vpc_link" "p_e_link" {
  name               = "p_e_link"
  security_group_ids = [aws_default_security_group.default.id]
  subnet_ids         = [aws_subnet.p_e_subnet.id]


  tags = {
    Pod = "test"
  }
}
