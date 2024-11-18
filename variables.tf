variable "barclays_name" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "availability_zone" {
  type    = string
  default = "eu-west-2b"
}

variable "aws_vpc_cidr" {
  type        = string
  description = "The AWS Region CIDR range to assign to the VPC"
  default     = "172.31.0.0/16"
}

variable "aws_subnet_cidr" {
  type    = string
  default = "172.31.32.0/24"
}