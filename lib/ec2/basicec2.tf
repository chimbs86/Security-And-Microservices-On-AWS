resource "aws_instance" "test" {


  ami = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.test_profile.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.id

  vpc_security_group_ids = [
    aws_security_group.allow_all.id]
  subnet_id = var.subnet_id

  user_data = "${base64encode(local.userdata)}"

  tags = {
    Name ="${var.vpc_name} -  ${random_id.id.hex}"
  }

}

output "ip" {
  value = aws_instance.test.public_ip
}

output "private_ip" {
  value = aws_instance.test.private_ip
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
  role = aws_iam_role.role.name
}


resource "aws_iam_role" "role" {
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
  description = "Allow TLS inbound traffic"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_outgoing" {
  from_port = 0
  protocol = "tcp"
  security_group_id = aws_security_group.allow_all.id
  to_port = 65535
  type = "egress"
  cidr_blocks = [
    "0.0.0.0/0"]
}

// I know this is not secure for a security book. So ... be careful and narrow this down
resource "aws_security_group_rule" "allow_incoming" {
  from_port = 0
  protocol = "tcp"
  security_group_id = aws_security_group.allow_all.id
  to_port = 65535
  type = "ingress"
  cidr_blocks = [
    "0.0.0.0/0"]
  description = var.vpc_id
}

resource "aws_key_pair" "deployer" {
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZ1wy14AkG3HP+jqWFDdj5MVvruW6tN56VvYwnb9R+CCJMhkDtYanqKooPpiE4zPIWy1zKz9M1oz61MKTs6cosPMdj2C5uuEl0snVbAQqv1KMY8JS/fUN6jYiIonv8zs5s1aTJ6LhhrTpFE0iLpV4oTwQmd8UrGJ5nm2lIZD7vGCthdG3ZMLhKSUZefnY8hWb0WFS6kM5GtCVKsYVMgHD3nwISs9eMhVhl1OpNGbo6/yKj98xJI52WBzCjC2cO4QCrPg5JnVdO2Kg9EHUPw3a1GNnUpDZim9YcdvDYMVfy64dETJOZSe8b/CGiQGdUHXvWssR9K6gMCnBacmLkHirrk/roVoICMN5WVBF9VpZpCsWC+RbVz0IxNE0d9zax/1PuYjaHfM7ZnNgKIocx3nYYJ+/J3qzxIv2D1RSWP5gCcf6BeobSntgEDeyp79NbarqJt7KB8XjQsYz6dfTKbmCMp8/k2r0PXbH1x7QV9nbhX8k8Hv+Qe3eVq3g5Y0HLKM0= gaurav.raje07@gmail.com"
}


resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id
}


resource "aws_route" "internet_route" {
  gateway_id = aws_internet_gateway.gw.id
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = var.route_table_id
}
resource "aws_main_route_table_association" "main_table_prod" {
  route_table_id = var.route_table_id
  vpc_id = var.vpc_id
}