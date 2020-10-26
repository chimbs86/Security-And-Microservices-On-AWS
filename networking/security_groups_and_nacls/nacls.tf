

resource "aws_network_acl" "block_smb_port" {
  vpc_id = aws_vpc.production_customer.id
subnet_ids = [aws_subnet.production_customer_a.id]
  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    from_port  = 443
    to_port    = 443
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 100
  }

  tags = {
    Name = "main"
  }
}