############################################
# DEV environment: composes the reusable modules
############################################

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project     = var.project
      Environment = var.environment
      ManagedBy   = "terraform"
      Owner       = "Usman Abubakar"
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  name         = "${var.project}-${var.environment}"
  cluster_name = "${local.name}-eks"
}

# ---------- Network ----------
module "vpc" {
  source = "../../modules/vpc"

  project            = local.name
  region             = var.region
  vpc_cidr           = var.vpc_cidr
  cluster_name       = local.cluster_name
  single_nat_gateway = var.single_nat_gateway
}

# ---------- Storage ----------
module "s3" {
  source = "../../modules/s3"

  bucket_name   = "${local.name}-storage-${data.aws_caller_identity.current.account_id}-${var.region}"
  force_destroy = var.bucket_force_destroy
}

# ---------- EC2 app server ----------
module "ec2" {
  source = "../../modules/ec2"

  project       = local.name
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.private_subnet_ids[0]
  instance_type = var.ec2_instance_type
  s3_bucket_arn = module.s3.bucket_arn
}

# ---------- EKS ----------
module "eks" {
  source = "../../modules/eks"

  project             = local.name
  cluster_name        = local.cluster_name
  kubernetes_version  = var.kubernetes_version
  cluster_subnet_ids  = concat(module.vpc.private_subnet_ids, module.vpc.public_subnet_ids)
  node_subnet_ids     = module.vpc.private_subnet_ids
  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size

  # Wait for NAT + routes so nodes can reach the internet when they boot
  depends_on = [module.vpc]
}

# ---------- RDS ----------
module "rds" {
  source = "../../modules/rds"

  project       = local.name
  vpc_id        = module.vpc.vpc_id
  db_subnet_ids = module.vpc.db_subnet_ids

  # Only the EC2 app server and the EKS nodes/pods can reach the database
  allowed_security_group_ids = [
    module.ec2.security_group_id,
    module.eks.cluster_security_group_id,
  ]

  db_name                 = var.db_name
  username                = var.db_username
  instance_class          = var.db_instance_class
  multi_az                = var.db_multi_az
  backup_retention_period = var.db_backup_retention_period
  skip_final_snapshot     = var.db_skip_final_snapshot
  deletion_protection     = var.db_deletion_protection
}
