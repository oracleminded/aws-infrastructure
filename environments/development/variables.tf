# ============================================================
# General settings
# ============================================================

variable "aws_region" {
  description = "AWS Region where the development environment is deployed."
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Project name used in AWS resource names and tags."
  type        = string
  default     = "mypawsbnb"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "development"

  validation {
    condition = contains(
      ["development", "qa", "staging", "production"],
      var.environment
    )

    error_message = "Environment must be development, qa, staging, or production."
  }
}


# ============================================================
# VPC and subnet settings
# ============================================================

variable "vpc_cidr" {
  description = "IPv4 CIDR block assigned to the development VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones used for the development subnets."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones must be provided."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks assigned to public subnets."
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks assigned to private application subnets."
  type        = list(string)
}

variable "private_database_subnet_cidrs" {
  description = "CIDR blocks assigned to private RDS subnets."
  type        = list(string)
}

variable "create_nat_gateway" {
  description = "Whether Terraform should create a NAT Gateway for private application subnets."
  type        = bool
  default     = false
}


# ============================================================
# On-premises network settings
# ============================================================

variable "on_premises_cidr" {
  description = "Specific on-premises CIDR permitted to connect to PostgreSQL."
  type        = string
}

variable "on_premises_network_cidr" {
  description = "On-premises network advertised to AWS through BGP."
  type        = string
}


# ============================================================
# Existing Site-to-Site VPN settings
# ============================================================

variable "customer_gateway_public_ip" {
  description = "Static public WAN IP address of the FortiGate customer gateway."
  type        = string
}

variable "customer_gateway_bgp_asn" {
  description = "BGP ASN used by the FortiGate customer gateway."
  type        = number
  default     = 65001

  validation {
    condition = (
      var.customer_gateway_bgp_asn >= 1 &&
      var.customer_gateway_bgp_asn <= 4294967294
    )

    error_message = "The customer gateway BGP ASN must be a valid ASN."
  }
}

variable "aws_bgp_asn" {
  description = "Amazon-side BGP ASN configured on the existing Virtual Private Gateway."
  type        = number
  default     = 64512
}

variable "vpn_local_ipv4_network_cidr" {
  description = "Customer-side network selector configured on the AWS VPN connection."
  type        = string
  default     = "0.0.0.0/0"
}

variable "vpn_remote_ipv4_network_cidr" {
  description = "AWS-side network selector configured on the AWS VPN connection."
  type        = string
  default     = "0.0.0.0/0"
}


# ============================================================
# PostgreSQL RDS settings
# ============================================================

variable "postgres_engine_version" {
  description = "PostgreSQL major or complete engine version used by RDS."
  type        = string
}

variable "postgres_parameter_group_family" {
  description = "RDS PostgreSQL parameter-group family."
  type        = string
}

variable "rds_instance_class" {
  description = "RDS DB instance class."
  type        = string
}

variable "rds_allocated_storage" {
  description = "Initial RDS storage allocation in GiB."
  type        = number

  validation {
    condition     = var.rds_allocated_storage >= 20
    error_message = "RDS allocated storage must be at least 20 GiB."
  }
}

variable "rds_max_allocated_storage" {
  description = "Maximum RDS storage autoscaling allocation in GiB."
  type        = number

  validation {
    condition = (
      var.rds_max_allocated_storage == 0 ||
      var.rds_max_allocated_storage >= var.rds_allocated_storage
    )

    error_message = "Maximum allocated storage must be zero or at least as large as allocated storage."
  }
}

variable "rds_multi_az" {
  description = "Whether the RDS instance uses a Multi-AZ deployment."
  type        = bool
  default     = false
}

variable "rds_backup_retention_days" {
  description = "Number of days RDS retains automated backups."
  type        = number
  default     = 7

  validation {
    condition = (
      var.rds_backup_retention_days >= 0 &&
      var.rds_backup_retention_days <= 35
    )

    error_message = "RDS backup retention must be between 0 and 35 days."
  }
}

variable "rds_deletion_protection" {
  description = "Whether RDS deletion protection is enabled."
  type        = bool
  default     = false
}

variable "rds_skip_final_snapshot" {
  description = "Whether RDS skips a final snapshot when destroyed."
  type        = bool
  default     = true
}

variable "rds_master_username" {
  description = "Master username for the PostgreSQL RDS instance."
  type        = string
  default     = "postgresadmin"

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9_]*$", var.rds_master_username))
    error_message = "The RDS master username must start with a letter and contain only letters, numbers, and underscores."
  }
}