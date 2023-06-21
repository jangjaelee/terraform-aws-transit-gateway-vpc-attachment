resource "null_resource" "validate_module_name" {
  count = local.module_name == var.tags["TerraformModuleName"] ? 0 : "Please check that you are using the Terraform module"
}

resource "null_resource" "validate_module_version" {
  count = local.module_version == var.tags["TerraformModuleVersion"] ? 0 : "Please check that you are using the Terraform module"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  transit_gateway_id = var.tgw_id
  vpc_id             = var.vpc_id
  subnet_ids         = var.subnet_ids

  dns_support                                     = var.enable_dns_support ? "enable" : "disable"
  ipv6_support                                    = var.enable_ipv6_support ? "enable" : "disable"
  appliance_mode_support                          = var.enable_appliance_mode_support ? "enable" : "disable"
  transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation

  tags = merge(
    var.tags, tomap(
      {"Name" = format("%s-%s-tgw-attachment", var.prefix, var.tgw_attachment_name)}
    )
  )  
}