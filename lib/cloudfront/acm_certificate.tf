
module "acm_request_certificate"  {
  source                            = "git::https://github.com/cloudposse/terraform-aws-acm-request-certificate.git?ref=master"
  domain_name                       = var.domain_name
  process_domain_validation_options = true
  ttl                               = "300"
}