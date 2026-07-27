# ------------------------------------------------------------
# General AWS settings
# ------------------------------------------------------------

aws_region   = "us-east-2"
project_name = "mypawsbnb"
environment  = "development"


# ------------------------------------------------------------
# VPC networking
# ------------------------------------------------------------

vpc_cidr = "10.10.0.0/16"

availability_zones = [
  "us-east-2a",
  "us-east-2b"
]


# Public subnets
# These can later contain an internet-facing Application Load Balancer.
public_subnet_cidrs = [
  "10.10.1.0/24",
  "10.10.2.0/24"
]


# Private application subnets
# These can later contain application servers, ECS tasks, or other
# application resources.
private_app_subnet_cidrs = [
  "10.10.11.0/24",
  "10.10.12.0/24"
]


# Private database subnets
# RDS will use these through an RDS DB subnet group.
private_database_subnet_cidrs = [
  "10.10.21.0/24",
  "10.10.22.0/24"
]


# You do not need a NAT Gateway merely to connect from your laptop
# to RDS through the FortiGate VPN.
create_nat_gateway = false


# ------------------------------------------------------------
# On-premises networking
# ------------------------------------------------------------

# The specific local subnet that may connect to PostgreSQL.
# This is used by the RDS security-group rule.
on_premises_cidr = "192.168.1.0/24"


# The broader network advertised through BGP by the FortiGate.
on_premises_network_cidr = "192.168.0.0/16"


# ------------------------------------------------------------
# Existing AWS Site-to-Site VPN
# ------------------------------------------------------------

# Replace this with the static public WAN IP used by your FortiGate.
# You can obtain it from the existing AWS Customer Gateway.
customer_gateway_public_ip = "32.216.6.237"

# Your FortiGate BGP ASN.
customer_gateway_bgp_asn = 65001

# Your existing AWS Virtual Private Gateway ASN.
aws_bgp_asn = 64512


# ------------------------------------------------------------
# PostgreSQL RDS
# ------------------------------------------------------------

postgres_engine_version = "18"

# Use the same family as the PostgreSQL major version.
postgres_parameter_group_family = "postgres17"

# Development-sized RDS instance.
rds_instance_class = "db.t4g.micro"

# Storage values are in GiB.
rds_allocated_storage     = 20
rds_max_allocated_storage = 100

# Development can be Single-AZ.
rds_multi_az = false

# Retain automated backups for seven days.
rds_backup_retention_days = 7

# Development safeguards.
rds_deletion_protection = false
rds_skip_final_snapshot = true

# RDS will manage the password in Secrets Manager when
# manage_master_user_password = true is configured in the module.
rds_master_username = "postgresadmin"