variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
variable "route_table_id" {
  type = string
}

variable "vpc_name" {
  default = ""
}

resource "random_id" "id" {
  byte_length = 8
}

// Download and install apache so you have a webserver on your test instance
locals {
  userdata = <<EOF
#! /bin/bash
sudo yum -y install httpd
sudo service httpd start
EOF
}