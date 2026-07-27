resource "aws_security_group" "rds" {
  name        = "${var.project_name}-${var.environment}-rds-sg"
  description = "Security group for PostgreSQL RDS"
  vpc_id      = var.vpc_id

  tags = {
    Name        = "${var.project_name}-${var.environment}-rds-sg"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_from_onprem" {
  security_group_id = aws_security_group.rds.id

  description = "PostgreSQL access from on-premises network through VPN"

  cidr_ipv4   = var.on_premises_cidr
  from_port   = var.postgres_port
  to_port     = var.postgres_port
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "rds_egress" {
  security_group_id = aws_security_group.rds.id

  description = "Allow outbound traffic from RDS security group"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}