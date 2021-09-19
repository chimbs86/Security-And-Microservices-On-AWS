variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  version = "~>3.0"

  region = var.aws_region
}

module "ses-email-forwarding" {
  source = "git@github.com:alemuro/terraform-ses-email-forwarding.git"

  dns_provider     = "aws"
  domain           = "mba.finance"
  s3_bucket        = "emails-setup"
  s3_bucket_prefix = "emails"
  mail_sender      = "gaurav@mba.finance"
  mail_recipient   = "gaurav.raje07@gmail.com"
  aws_region       = "us-east-1"
}