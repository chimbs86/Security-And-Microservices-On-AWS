provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}

provider "random" {
  version = "2.2"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

module "vpc_marketing" {
  source = "./vpc"
  name   = "marketing"
  cidr_subnet = "10.0.0.0/24"
  cidr_vpc = "10.0.0.0/16"
  subnet_name = "marketing"
}

module "vpc_finance" {
  source = "./vpc"
  name   = "finance"
  cidr_subnet = "10.0.0.0/24"
  cidr_vpc = "10.0.0.0/16"
  subnet_name = "finance"
}

