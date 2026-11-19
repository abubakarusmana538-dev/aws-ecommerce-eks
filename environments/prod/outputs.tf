output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "db_subnet_ids" {
  value = module.vpc.db_subnet_ids
}

output "s3_bucket" {
  value = module.s3.bucket_name
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "rds_secret_arn" {
  description = "Secrets Manager secret holding the DB master password"
  value       = module.rds.secret_arn
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_kubeconfig_command" {
  value = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}
