variable "project" {
  description = "Name prefix for all resources (e.g. ecommerce-dev)"
  type        = string
}

variable "region" {
  description = "AWS region (used for the S3 gateway endpoint service name)"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block. Subnets are carved out of it as /24s."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name, used for Kubernetes subnet discovery tags"
  type        = string
}

variable "az_count" {
  description = "Number of Availability Zones to use"
  type        = number
  default     = 2
}

variable "single_nat_gateway" {
  description = "true = one shared NAT (cheap, dev). false = one NAT per AZ (HA, prod)."
  type        = bool
  default     = true
}
