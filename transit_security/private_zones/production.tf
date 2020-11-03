resource "aws_vpc" "production" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"

  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "production"
  }
}


resource "aws_subnet" "production_customer" {
  vpc_id = aws_vpc.production.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "production"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.production.id

  tags = {
    Name = "main"
  }
}


resource "aws_default_route_table" "production_route" {
  tags = {
    Name = "Production Route Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  default_route_table_id = aws_vpc.production.default_route_table_id
}


data "aws_ami" "amazon-linux-2" {
  most_recent = true


  filter {
    name = "owner-alias"
    values = [
      "amazon"]
  }
  owners = [
    "amazon"]


  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm*"]
  }
}


resource "aws_iam_instance_profile" "test_profile" {
  name = "test_profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "test_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


resource "aws_security_group" "allow_all" {
  name = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.production.id

  ingress {
    description = "TLS from VPC"
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_instance" "test" {


  ami = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.test_profile.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.id

  vpc_security_group_ids = [
    aws_security_group.allow_all.id]
  subnet_id = aws_subnet.production_customer.id

}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key-pair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZ1wy14AkG3HP+jqWFDdj5MVvruW6tN56VvYwnb9R+CCJMhkDtYanqKooPpiE4zPIWy1zKz9M1oz61MKTs6cosPMdj2C5uuEl0snVbAQqv1KMY8JS/fUN6jYiIonv8zs5s1aTJ6LhhrTpFE0iLpV4oTwQmd8UrGJ5nm2lIZD7vGCthdG3ZMLhKSUZefnY8hWb0WFS6kM5GtCVKsYVMgHD3nwISs9eMhVhl1OpNGbo6/yKj98xJI52WBzCjC2cO4QCrPg5JnVdO2Kg9EHUPw3a1GNnUpDZim9YcdvDYMVfy64dETJOZSe8b/CGiQGdUHXvWssR9K6gMCnBacmLkHirrk/roVoICMN5WVBF9VpZpCsWC+RbVz0IxNE0d9zax/1PuYjaHfM7ZnNgKIocx3nYYJ+/J3qzxIv2D1RSWP5gCcf6BeobSntgEDeyp79NbarqJt7KB8XjQsYz6dfTKbmCMp8/k2r0PXbH1x7QV9nbhX8k8Hv+Qe3eVq3g5Y0HLKM0= gaurav.raje07@gmail.com"
}


resource "aws_route53_zone" "private" {
  name = "google.com"


  vpc {
    vpc_id = aws_vpc.production.id
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.id
  name = "google.com"
  type = "A"
  ttl = "5"
  records = [
    "34.226.135.72"]
}