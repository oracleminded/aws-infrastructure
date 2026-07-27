variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "private_route_table_ids" {
  type = list(string)
}

variable "customer_gateway_public_ip" {
  type      = string
  sensitive = true
}

variable "customer_gateway_bgp_asn" {
  type = number
}

variable "aws_bgp_asn" {
  type = number
}

variable "on_premises_network_cidr" {
  type = string
}