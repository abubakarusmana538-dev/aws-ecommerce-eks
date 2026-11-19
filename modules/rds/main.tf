############################################
# RDS module: PostgreSQL in isolated subnets
############################################

resource "aws_security_group" "db" {
  name        = "${var.project}-db-sg"
  description = "RDS PostgreSQL"
  vpc_id      = var.vpc_id
  tags        = { Name = "${var.project}-db-sg" }
}

resource "aws_vpc_security_group_ingress_rule" "from_allowed" {
  count                        = length(var.allowed_security_group_ids)
  security_group_id            = aws_security_group.db.id
  referenced_security_group_id = var.allowed_security_group_ids[count.index]
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  description                  = "PostgreSQL from allowed security group ${count.index + 1}"
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-db-subnets"
  subnet_ids = var.db_subnet_ids
  tags       = { Name = "${var.project}-db-subnets" }
}

resource "aws_db_instance" "this" {
  identifier        = "${var.project}-db"
  engine            = "postgres"
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.username
  # Password is generated and stored in Secrets Manager by AWS
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.db.id]
  publicly_accessible    = false
  multi_az               = var.multi_az

  backup_retention_period   = var.backup_retention_period
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : "${var.project}-final-snapshot"
  deletion_protection       = var.deletion_protection

  tags = { Name = "${var.project}-db" }
}
