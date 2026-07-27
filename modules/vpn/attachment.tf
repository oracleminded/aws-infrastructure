resource "aws_vpn_gateway_attachment" "postgresmigration" {
  vpc_id         = var.vpc_id
  vpn_gateway_id = aws_vpn_gateway.postgresmigration.id
}