resource "aws_network_acl" "block_smb_port" {
  vpc_id = aws_vpc.production_customer.id
  subnet_ids = [
    aws_subnet.production_customer_a.id]
  egress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    from_port = 80
    to_port = 80
    cidr_block = "0.0.0.0/0"
  }
  ingress {
    protocol = "tcp"
    rule_no = 101
    action = "allow"
    from_port = 80
    to_port = 80
    cidr_block = "0.0.0.0/0"
  }
  egress {
    protocol = "tcp"
    rule_no = 200
    action = "deny"
    cidr_block = "0.0.0.0/0"
    from_port = 445
    to_port = 445
  }

  tags = {
    Name = "main1"
  }
}
