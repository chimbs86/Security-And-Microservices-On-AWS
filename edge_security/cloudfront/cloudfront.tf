resource "aws_s3_bucket" "b" {
  bucket = "testoriginchimbs"
  acl    = "private"

  tags = {
    Name = "testoriginchimbs"
  }
}

locals {
  s3_origin_id = "myS3Origin"
}

module "cloudfront_distribution" {
  source = "../../lib/cloudfront"
  certificate_arn = module.acm_request_certificate.arn
  domain_name = "fallacyis.com"
  origin_bucket_name = aws_s3_bucket.b.bucket_regional_domain_name
  origin_id = local.s3_origin_id
}

module "acm_request_certificate"  {
  source                            = "git::https://github.com/cloudposse/terraform-aws-acm-request-certificate.git?ref=master"
  domain_name                       = "fallacyis.com"
  process_domain_validation_options = true
  ttl                               = "300"
}