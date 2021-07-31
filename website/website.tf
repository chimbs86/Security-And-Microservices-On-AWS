locals {
  aws_account_id = "248285616257"
  aws_region     = "eu-west-1"
  site_name      = "rite"
  profile        = "rite"
  site_domain    = "rite.click"
}

data "aws_caller_identity" "current" {}

module "peterdotcloud_website" {
  source         = "TechToSpeech/serverless-static-wordpress/aws"
  version        = "0.1.0"
  main_vpc_id    = "vpc-0ddea9dbb66155fdf"
  subnet_ids     = ["subnet-080309f399ac79d92","subnet-0a99b670c9f21bb1c"]
  aws_account_id = data.aws_caller_identity.current.account_id

  # site_name will be used to prepend resource names - use no spaces or special characters
  site_name           = local.site_name
  site_domain         = local.site_domain
  wordpress_subdomain = "wordpress"
  hosted_zone_id      = "Z04894253JHSHKJA48M9J"
  s3_region           = local.aws_region

  # Send ECS and RDS events to Slack
  slack_webhook       = "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX"
  ecs_cpu             = 1024
  ecs_memory          = 2048
  cloudfront_aliases  = ["www.rite.click", "rite.click"]
  waf_enabled         = true

  # Provides the toggle to launch Wordpress container
  launch         = 0

  ## Passing in Provider block to module is essential
  providers = {
    aws.ue1 = aws.ue1
  }
}
module "docker_pullpush" {
  source         = "TechToSpeech/ecr-mirror/aws"
  version        = "0.0.6"
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = local.aws_region
  docker_source  = "wordpress:php7.4-apache"
  aws_profile    = "rite"
  ecr_repo_name  = module.peterdotcloud_website.wordpress_ecr_repository
  ecr_repo_tag   = "base"
  depends_on     = [module.peterdotcloud_website]
}