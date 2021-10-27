variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  version = "~>3.0"

  region = var.aws_region
}
resource "aws_cloudfront_public_key" "example" {
  comment     = "test public key"
  encoded_key = file("public.pem")
  name        = "test_key"
}