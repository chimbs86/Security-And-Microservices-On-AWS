variable "customer_vpc_cidr" {
  type = string
}
variable "customer_subnet_cidr" {
  type = string
}
variable "marketing_vpc_cidr" {
  type = string
}
variable "marketing_subnet_cidr" {
  type = string
}
variable "finance_vpc_cidr" {
  type = string
}
variable "finance_subnet_cidr" {
  type = string
}
variable "default_az" {
  default = "us-east-1a"
}
variable "finance_vpc_name" {
  default = "finance"
}
variable "customer_vpc_name" {
  default = "customer"
}
variable "marketing_vpc_name" {
  default = "marketing"
}

variable "finance_subnet_name" {
  default = "finance_subnet"
}
variable "customer_subnet_name" {
  default = "customer_subnet"
}
variable "marketing_subnet_name" {
  default = "marketing_subnet"
}

variable "ec2_inside_each" {
  default = 1
}