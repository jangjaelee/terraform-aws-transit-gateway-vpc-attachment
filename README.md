# AWS Transit Gateway VPC Attachment Terraform module

Terraform module which creates Transit Gateway VPC Attachment resources on AWS.

These types of resources are supported:

* [Transit Gateway VPC Attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment)


## Usage
### Create Transit Gateway VPC Attachment

main.tf
```hcl
module "tgw_vpc_attachment" {
  source = "git@git@github.com:jangjaelee/terraform-aws-transit-gateway-vpc-attachment.git"

  tgw_name       = var.tgw_name
  tgw_id         = var.tgw_id
  vpc_id         = var.vpc_id
  subnet_ids     = var.subnet_ids

  enable_dns_support                              = var.enable_dns_support
  enable_ipv6_support                             = var.enable_ipv6_support
  enable_appliance_mode_support                   = var.enable_appliance_mode_support
  transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation

  env = var.env
}
```

providers.tf
```hcl
provider "aws" {
  region = var.region
  allowed_account_ids = var.account_id
  profile = "eks_service"
}
```

terraform.tf
```hcl
terraform {
  required_version = ">= 0.15.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.43.0"
    }
  }

  backend "s3" {
    bucket = "kubesphere-terraform-state-backend"
    key = "kubesphere/tgw-vpc-attachment/terraform.tfstate"
    dynamodb_table = "kubesphere-terraform-state-locks"
    encrypt = true
    region = "ap-northeast-2"
    profile = "eks_service"
  }
}
```

variables.tf
```hcl
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "account_id" {
  description = "List of Allowed AWS account IDs"
  type        = list(string)
  default     = ["123456789012"]
}

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
```

terraform.tfvars
```hcl
region     = "ap-northeast-2"
account_id = ["123456789012"]
tgw_name   = "KubeSphere-dev"
tgw_id     = "tgw-0b4f8e631547a3035"
vpc_id     = "vpc-0ea3953e6e8c1bcbc"
subnet_ids = ["subnet-0b7756fdf12626673","subnet-0b3356a36c9a256e0"]
enable_dns_support                              = true
enable_ipv6_support                             = false
enable_appliance_mode_support                   = false
transit_gateway_default_route_table_association = true
transit_gateway_default_route_table_propagation = true
env = "dev"
```

output.tf
```hcl
output "tgw_vpc_attachment_id" {
  value = module.tgw_vpc_attachment.tgw_vpc_attachment_id
}

output "tgw_vpc_attachment_tags_all" {
  value = module.tgw_vpc_attachment.tgw_vpc_attachment_tags_all
}

output "tgw_vpc_attachment_vpc_owner_id" {
  value = module.tgw_vpc_attachment.tgw_vpc_attachment_vpc_owner_id
}
```
