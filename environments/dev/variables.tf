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
  default = "dev"
}

# ---------- Network ----------
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "single_nat_gateway" {
  description = "One shared NAT keeps dev cheap"
  type        = bool
  default     = true
}

# ---------- EKS ----------
variable "kubernetes_version" {
  description = "null = AWS default version"
  type        = string
  default     = null
}

variable "node_instance_types" {
  description = "t3.small is free-tier eligible"
  type        = list(string)
  default     = ["t3.small"]
}

variable "node_desired_size" {
  type    = number
  default = 2
}

variable "node_min_size" {
  type    = number
  default = 2
}

variable "node_max_size" {
  type    = number
  default = 3
}

# ---------- EC2 ----------
variable "ec2_instance_type" {
  type    = string
  default = "t3.micro"
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
  default = "db.t3.micro"
}

variable "db_multi_az" {
  type    = bool
  default = false
}

variable "db_backup_retention_period" {
  description = "Free-tier accounts allow at most 1 day"
  type        = number
  default     = 1
}

variable "db_skip_final_snapshot" {
  type    = bool
  default = true
}

variable "db_deletion_protection" {
  type    = bool
  default = false
}

# ---------- S3 ----------
variable "bucket_force_destroy" {
  description = "Let terraform destroy empty and delete the bucket"
  type        = bool
  default     = true
}
