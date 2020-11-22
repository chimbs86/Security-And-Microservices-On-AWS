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

module "vpc" {
  source = "./vpc"
  name   = "media"
  cidr_subnet = "10.0.0.0/24"
  cidr_vpc = "10.0.0.0/16"
  subnet_name = "customera"
}