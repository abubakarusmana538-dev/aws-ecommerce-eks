variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "project" {
  type    = string
  default = "ecommerce"
}

variable "environment" {
  type    = string
  default = "prod"
}

# ---------- Network ----------
variable "vpc_cidr" {
  description = "Different range from dev so the two VPCs can be peered later"
  type        = string
  default     = "10.1.0.0/16"
}

variable "single_nat_gateway" {
  description = "One NAT per AZ so an AZ failure does not cut off outbound traffic"
  type        = bool
  default     = false
}

# ---------- EKS ----------
variable "kubernetes_version" {
  description = "Pin an explicit version in prod, e.g. 1.34"
  type        = string
  default     = null
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "node_desired_size" {
  type    = number
  default = 3
}

variable "node_min_size" {
  type    = number
  default = 2
}

variable "node_max_size" {
  type    = number
  default = 6
}

# ---------- EC2 ----------
variable "ec2_instance_type" {
  type    = string
  default = "t3.small"
}

# ---------- RDS ----------
variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "dbadmin"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.small"
}

variable "db_multi_az" {
  type    = bool
  default = true
}

variable "db_backup_retention_period" {
  type    = number
  default = 7
}

variable "db_skip_final_snapshot" {
  type    = bool
  default = false
}

variable "db_deletion_protection" {
  type    = bool
  default = true
}

# ---------- S3 ----------
variable "bucket_force_destroy" {
  description = "Keep false in prod so a destroy can never wipe stored data"
  type        = bool
  default     = false
}
