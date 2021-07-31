variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  version = "~> 3.0"
  alias   = "ue1"

  region = var.aws_region
}
