module "network" {
  source = "../../modules/network"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr                     = var.vpc_cidr
  availability_zones           = var.availability_zones
  public_subnet_cidrs           = var.public_subnet_cidrs
  private_app_subnet_cidrs      = var.private_app_subnet_cidrs
  private_database_subnet_cidrs = var.private_database_subnet_cidrs

  create_nat_gateway = false
}

module "security" {
  source = "../../modules/security"

  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.network.vpc_id
  on_premises_cidr = var.on_premises_cidr
}

module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  database_subnet_ids = module.network.private_database_subnet_ids

  vpc_security_group_ids = [
    module.security.rds_security_group_id
  ]

  engine_version        = var.postgres_engine_version
  instance_class        = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  max_allocated_storage = var.rds_max_allocated_storage
  multi_az              = var.rds_multi_az

  backup_retention_days = var.rds_backup_retention_days
  deletion_protection   = var.rds_deletion_protection
  skip_final_snapshot   = var.rds_skip_final_snapshot
  master_username       = var.rds_master_username
}

module "vpn" {
  source = "../../modules/vpn"

  project_name = var.project_name
  environment  = var.environment

  vpc_id                  = module.network.vpc_id
  vpc_cidr                = var.vpc_cidr
  private_route_table_ids = module.network.private_route_table_ids

  customer_gateway_public_ip = var.customer_gateway_public_ip
  customer_gateway_bgp_asn   = 65001
  aws_bgp_asn                = 64512
  on_premises_network_cidr   = var.on_premises_network_cidr
}