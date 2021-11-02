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
    {
      "Name" = format("%s-tgw-vpc-attachment", var.tgw_name)
    },
    local.common_tags,
  )
}
