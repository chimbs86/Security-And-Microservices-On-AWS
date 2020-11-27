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
  web_acl_arn = aws_waf_web_acl.waf_acl.arn
}

resource "aws_waf_ipset" "ipset" {
  name = "IPSet"

  ip_set_descriptors {
    type  = "IPV4"
    value = "74.73.92.97/32"
  }
}

resource "aws_waf_rule" "wafrule" {
  depends_on  = [aws_waf_ipset.ipset]
  name        = "WAFRule"
  metric_name = "WAFRuleMetric"

  predicates {
    data_id = aws_waf_ipset.ipset.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "waf_acl" {
  depends_on = [
    aws_waf_ipset.ipset,
    aws_waf_rule.wafrule,
  ]
  name        = "tfWebACL"
  metric_name = "tfWebACL"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = aws_waf_rule.wafrule.id
    type     = "REGULAR"
  }
}