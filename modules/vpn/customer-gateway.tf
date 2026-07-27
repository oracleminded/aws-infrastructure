resource "aws_customer_gateway" "fortigate" {
  bgp_asn    = var.customer_gateway_bgp_asn
  ip_address = var.customer_gateway_public_ip
  type       = "ipsec.1"
  device_name = "FortiGate-60F"

  tags = {
    Name        = "${var.project_name}-${var.environment}-fortigate"
    Project     = var.project_name
    Environment = var.environment
  }
}