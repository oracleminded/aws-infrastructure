resource "aws_vpn_gateway_route_propagation" "private" {
  for_each = toset(var.private_route_table_ids)

  vpn_gateway_id = aws_vpn_gateway.postgresmigration.id
  route_table_id = each.value

  depends_on = [
    aws_vpn_gateway_attachment.postgresmigration
  ]
}