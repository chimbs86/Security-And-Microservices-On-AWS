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