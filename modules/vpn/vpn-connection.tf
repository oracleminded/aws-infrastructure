resource "aws_vpn_connection" "postgresmigration" {
  customer_gateway_id = aws_customer_gateway.fortigate.id
  vpn_gateway_id      = aws_vpn_gateway.postgresmigration.id

  type               = "ipsec.1"
  static_routes_only = false

  local_ipv4_network_cidr  = var.on_premises_network_cidr
  remote_ipv4_network_cidr = var.vpc_cidr

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpn"
    Project     = var.project_name
    Environment = var.environment
  }
}