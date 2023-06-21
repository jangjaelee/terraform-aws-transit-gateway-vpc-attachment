variable "region" {
  description = "List of Allowed AWS account IDs"
  type        = string
}

variable "account_id" {
  description = "Allowed AWS account IDs"
  type        = string
}

variable "prefix" {
  description = "prefix for aws resources and tags"
  type        = string
}

variable "vpc_id" {
  description = "Identifier of Amazon VPC"
  type        = string
}

variable "subnet_ids" {
  description = "Set of VPC Subnet ID-s for the subnet group. At least one subnet must be provided"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "tag map"
  type        = map(string)
}

variable "tgw_id" {
  description = "Identifier of AWS Transit Gateway"
  type        = string
}

variable "tgw_attachment_name" {
  description = "Name to be used on all the resources as identifier for Transit Gateway Attachment"
  type        = string
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