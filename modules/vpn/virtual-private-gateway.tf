resource "aws_vpn_gateway" "postgresmigration" {
  amazon_side_asn = var.aws_bgp_asn

  tags = {
    Name        = "${var.project_name}-${var.environment}-vgw"
    Project     = var.project_name
    Environment = var.environment
  }
}