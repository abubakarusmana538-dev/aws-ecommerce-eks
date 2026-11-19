variable "project" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version. null = AWS default."
  type        = string
  default     = null
}

variable "cluster_subnet_ids" {
  description = "Subnets for the control plane ENIs (private + public so load balancers can be created)"
  type        = list(string)
}

variable "node_subnet_ids" {
  description = "Private subnets for worker nodes"
  type        = list(string)
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
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
  default = 4
}
