
# AWS S3 bucket for static hosting
variable "website_bucket_name" {
  default = "website-chimbs"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  version = "~> 3.0"
  region = var.aws_region
}
