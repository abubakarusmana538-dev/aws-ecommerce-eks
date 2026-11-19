variable "project" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "db_subnet_ids" {
  description = "Isolated DB subnets"
  type        = list(string)
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to connect on the database port"
  type        = list(string)
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "username" {
  type    = string
  default = "dbadmin"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "engine_version" {
  type    = string
  default = "16"
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  description = "Days to keep backups. Free-tier accounts allow at most 1."
  type        = number
  default     = 1
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = false
}
