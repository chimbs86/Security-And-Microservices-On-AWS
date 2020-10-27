variable "aws_region" {
  type    = string
  default = "us-east-1"
}
# AWS S3 bucket for static hosting
variable "website_bucket_name" {
  default = "website-chimbs"
}