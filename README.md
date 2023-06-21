# AWS Transit Gateway VPC Attachment Terraform module

Terraform module which creates Transit Gateway VPC Attachment resources on AWS.

These types of resources are supported:

* [Transit Gateway VPC Attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment)


## Usage
### Create Transit Gateway VPC Attachment

`main.tf`
```hcl
module "tgw_vpc_attachment" {
  source = "git@git@github.com:jangjaelee/terraform-aws-transit-gateway-vpc-attachment.git"

  account_id = var.account_id
  region     = var.region
  prefix     = var.prefix
  vpc_id     = data.aws_vpc.this.id
  subnet_ids = data.aws_subnet_ids.this.ids
  tags       = var.tags
  tgw_id     = var.tgw_id
  tgw_attachment_name = var.tgw_attachment_name
  
  enable_dns_support                              = var.enable_dns_support
  enable_ipv6_support                             = var.enable_ipv6_support
  enable_appliance_mode_support                   = var.enable_appliance_mode_support
  transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation
}
```
---

`provider.tf`
```hcl
provider "aws" {
  region = var.region
  #allowed_account_ids = var.account_id
  shared_credentials_file = "~/.aws/credentials"
  profile = "tgw_vpc_attachment"

  assume_role {
    role_arn     = "arn:aws:iam::123456789012:role/test"
    #session_name = "test"
    #external_id  = "EXTERNAL_ID"
  }  
}
```
---

`terraform.tf`
```hcl
terraform {
  required_version = ">= 1.1.3"
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.72"
    }
  }

  backend "s3" {
    bucket = "kubesphere-terraform-state-backend" # S3 bucket 이름 변경(필요 시)
    key = "kubesphere/tgw-vpc-attachment/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "" # 다이나모 테이블 이름 변경(필요 시)
    encrypt = true
    profile = "default"
  }
}
```
---

`variables.tf`
```hcl
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

variable "vpc_name" {
  description = "Name to be used on all the resources as identifier for VPC"
  type        = string
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

variable "tgw_attachment_subnet_filters" {
  description = "Filters to select private subnets"
  type = map(any)
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
```
---

`terraform.tfvars`
```hcl
region     = "ap-northeast-2" # 리전 변경 필수
account_id = "123456789012" # 아이디 변경 필수
prefix     = "dev"
vpc_name   = "jjlee" # 최종 VPC 이름: ${prefix}.${vpc_name}
tgw_id     = "tgw-0c02f06f6c448f2ac" # Trangit Gateway ID 필수
tgw_attachment_name = "jjlee"

enable_dns_support                              = true
enable_ipv6_support                             = false
enable_appliance_mode_support                   = true
transit_gateway_default_route_table_association = false
transit_gateway_default_route_table_propagation = false

tgw_attachment_subnet_filters = {
  "Name" = [ "dev-jjlee-vpc-tgw-attachment-subnet-2a", "dev-jjle-vpc-tgw-attachment-subnet-2c"]
}

# 공통 tag, 생성되는 모든 리소스에 태깅
tags = {
    "CreatedByTerraform" = "true"
    "TerraformModuleName" = "terraform-aws-module-transit-gateway-vpc-attachment"
    "TeffaformModuleVersion" = "v1.0.0"
}
```
---

`outputs.tf`
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

`data.tf`
```hcl
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.prefix}-${var.vpc_name}-vpc"]
  }
}

data "aws_subnet_ids" "this" {
  vpc_id = data.aws_vpc.this.id
  dynamic "filter" {
    for_each = var.tgw_attachment_subnet_filters
    iterator = tag
    content {
      name   = "tag:${tag.key}"
      values = "${tag.value}"
    }
  }
}
```
