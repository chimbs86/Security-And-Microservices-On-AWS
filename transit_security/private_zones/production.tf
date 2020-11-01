resource "aws_vpc" "production" {
  cidr_block = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "production"
  }
}


resource "aws_subnet" "production_customer" {
  vpc_id = aws_vpc.production.id
  cidr_block = "10.1.1.0/24"

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
  vpc_id = aws_vpc.production.id
  tags = {
    Name = "Production Route Table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    network_interface_id = aws_internet_gateway.gw.id
  }


  default_route_table_id = aws_vpc.production.default_route_table_id
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  owners = [
    "099720109477"]
  # Canonical
}

resource "aws_key_pair" "deployer" {
  key_name = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZ1wy14AkG3HP+jqWFDdj5MVvruW6tN56VvYwnb9R+CCJMhkDtYanqKooPpiE4zPIWy1zKz9M1oz61MKTs6cosPMdj2C5uuEl0snVbAQqv1KMY8JS/fUN6jYiIonv8zs5s1aTJ6LhhrTpFE0iLpV4oTwQmd8UrGJ5nm2lIZD7vGCthdG3ZMLhKSUZefnY8hWb0WFS6kM5GtCVKsYVMgHD3nwISs9eMhVhl1OpNGbo6/yKj98xJI52WBzCjC2cO4QCrPg5JnVdO2Kg9EHUPw3a1GNnUpDZim9YcdvDYMVfy64dETJOZSe8b/CGiQGdUHXvWssR9K6gMCnBacmLkHirrk/roVoICMN5WVBF9VpZpCsWC+RbVz0IxNE0d9zax/1PuYjaHfM7ZnNgKIocx3nYYJ+/J3qzxIv2D1RSWP5gCcf6BeobSntgEDeyp79NbarqJt7KB8XjQsYz6dfTKbmCMp8/k2r0PXbH1x7QV9nbhX8k8Hv+Qe3eVq3g5Y0HLKM0= gaurav.raje07@gmail.com"
}


resource "aws_instance" "web" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.production_customer.id
  key_name = aws_key_pair.deployer.key_name
  tags = {
    Name = "microservice"
  }
}