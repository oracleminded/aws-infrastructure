# ============================================================
# Network outputs
# ============================================================

output "vpc_id" {
  description = "ID of the development VPC."
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.network.public_subnet_ids
}

output "private_app_subnet_ids" {
  description = "IDs of the private application subnets."
  value       = module.network.private_app_subnet_ids
}

output "private_database_subnet_ids" {
  description = "IDs of the private database subnets."
  value       = module.network.private_database_subnet_ids
}

output "private_route_table_ids" {
  description = "IDs of the private route tables receiving VPN route propagation."
  value       = module.network.private_route_table_ids
}


# ============================================================
# Security outputs
# ============================================================

output "rds_security_group_id" {
  description = "ID of the security group attached to PostgreSQL RDS."
  value       = module.security.rds_security_group_id
}


# ============================================================
# RDS outputs
# ============================================================

output "rds_instance_id" {
  description = "Terraform/AWS ID of the PostgreSQL RDS instance."
  value       = module.rds.db_instance_id
}

output "rds_identifier" {
  description = "AWS DB identifier of the PostgreSQL RDS instance."
  value       = module.rds.db_identifier
}

output "rds_endpoint" {
  description = "DNS hostname used to connect to PostgreSQL RDS."
  value       = module.rds.db_endpoint
}

output "rds_port" {
  description = "TCP port used by PostgreSQL RDS."
  value       = module.rds.db_port
}

output "rds_database_name" {
  description = "Initial database name created on the RDS instance."
  value       = module.rds.database_name
}

output "rds_master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the RDS master credentials."
  value       = module.rds.master_user_secret_arn
  sensitive   = true
}


# ============================================================
# Site-to-Site VPN outputs
# ============================================================

output "customer_gateway_id" {
  description = "ID of the imported FortiGate AWS Customer Gateway."
  value       = module.vpn.customer_gateway_id
}

output "vpn_gateway_id" {
  description = "ID of the imported AWS Virtual Private Gateway."
  value       = module.vpn.vpn_gateway_id
}

output "vpn_connection_id" {
  description = "ID of the imported AWS Site-to-Site VPN connection."
  value       = module.vpn.vpn_connection_id
}

output "vpn_tunnel1_outside_ip" {
  description = "AWS public outside IP address for VPN tunnel 1."
  value       = module.vpn.tunnel1_address
}

output "vpn_tunnel2_outside_ip" {
  description = "AWS public outside IP address for VPN tunnel 2."
  value       = module.vpn.tunnel2_address
}