output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_security_group_id" {
  description = "Security group attached to nodes and control plane ENIs"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}
