variable "aws_region" {
  type    = string
  default = "us-east-1"
}

locals {
  customer = {
    customer_subnet_cidr = "10.0.0.0/24"
    customer_vpc_cidr = "10.0.0.0/16"
  }
  finance = {
    finance_subnet_cidr = "10.1.0.0/24"
    finance_vpc_cidr = "10.1.0.0/16"
  }
  marketing = {
    marketing_subnet_cidr = "10.2.0.0/24"
    marketing_vpc_cidr = "10.2.0.0/16"
  }

}