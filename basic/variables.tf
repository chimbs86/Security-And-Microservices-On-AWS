variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  version = "2.33.0"

  region = var.aws_region
}

provider "random" {
  version = "2.2"
}