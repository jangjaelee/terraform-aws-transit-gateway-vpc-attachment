output "tgw_vpc_attachment_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.this.id
}

output "tgw_vpc_attachment_tags_all" {
  value = aws_ec2_transit_gateway_vpc_attachment.this.tags_all
}

output "tgw_vpc_attachment_vpc_owner_id" {
  value = aws_ec2_transit_gateway_vpc_attachment.this.vpc_owner_id
}