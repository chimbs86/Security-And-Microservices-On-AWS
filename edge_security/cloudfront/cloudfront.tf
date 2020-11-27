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
  domain_name = "fallacyis.com"
  origin_bucket_name = aws_s3_bucket.b.bucket_regional_domain_name
  origin_id = local.s3_origin_id
}
