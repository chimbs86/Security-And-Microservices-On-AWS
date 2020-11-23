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
locals {
  userdata= <<EOF
sudo yum -y install httpd
sudo service httpd start
EOF
}