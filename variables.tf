variable "tgw_name" {
  description = "Name to be used on all the resources as identifier for Transit Gateway"
  type        = string
}

variable "tgw_id" {
  description = "Identifier of AWS Transit Gateway"
  type        = string
}

variable "vpc_id" {
  description = "Identifier of Amazon VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Identifiers of Subnets"
  type        = list(string)
}

variable "enable_dns_support" {
  description = "Whether DNS support is enabled"
  type        = bool
  default     = true
}

variable "enable_ipv6_support" {
  description = "Whether IPv6 support is enabled"
  type        = bool
  default     = false
}

variable "enable_appliance_mode_support" {
  description = "Whether Appliance Mode support is enabled"
  type        = bool
  default     = false
}

variable "transit_gateway_default_route_table_association" {
  description = "Boolean whether the VPC Attachment should be associated with the EC2 Transit Gateway association default route table"
  type        = bool
  default     = true
}

variable "transit_gateway_default_route_table_propagation" {
  description = "Boolean whether the VPC Attachment should propagate routes with the EC2 Transit Gateway propagation default route table"
  type        = bool
  default     = true
}

variable "env" {
  description = "Environment"
  type        = string
}
