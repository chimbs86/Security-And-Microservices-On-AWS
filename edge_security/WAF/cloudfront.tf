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
  web_acl_arn = aws_wafv2_web_acl.test.arn
}



resource "aws_wafv2_rule_group" "example" {
  capacity = 10
  name     = "example-rule-group"
  scope    = "CLOUDFRONT"

  rule {
    name     = "rule-1"
    priority = 1

    action {
      count {}
    }

    statement {
     ip_set_reference_statement {
       arn = aws_wafv2_ip_set.my_ip_set.arn
     }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl" "test" {
  name  = "rule-group-example"
  scope = "CLOUDFRONT"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.example.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_ip_set" "my_ip_set" {
  name               = "WAFIpSet"
  description        = "Example IP set"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = ["74.73.92.98/32"]

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }
}