locals {
  sg_ids = var.create_security_group ? [aws_security_group.security_group[0].id] : []
}
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier        = var.cluster_identifier
  engine                    = var.engine
  engine_version            = var.engine_version
  engine_mode               = var.engine_mode
  database_name             = var.database_name
  master_username           = var.master_username
  master_password           = var.master_password
  storage_encrypted         = var.storage_encrypted
  backup_retention_period   = var.backup_retention_period
  preferred_backup_window   = var.preferred_backup_window
  # storage_type              = var.storage_type
  # db_cluster_instance_class = var.instance_class
  # allocated_storage         = var.allocated_storage
  vpc_security_group_ids    = setunion(local.sg_ids, var.additional_security_group_ids)

  db_subnet_group_name = var.db_subnet_group_name
  availability_zones   = var.availability_zones

  serverlessv2_scaling_configuration {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  tags = merge(var.tags, {
    "Environment" = var.env,
    "Name"        = var.cluster_identifier
    "Service"     = "aurora-postgres"
  })
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {
  count               = var.instance_count
  identifier          = "${var.cluster_identifier}-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = var.instance_class
  publicly_accessible = false
  engine              = var.engine
  engine_version      = var.engine_version

  db_subnet_group_name = var.db_subnet_group_name
  # monitoring_role_arn        = var.monitoring_role_arn
  monitoring_interval          = var.monitoring_interval
  availability_zone            = var.availability_zones[count.index]
  performance_insights_enabled = var.performance_insights_enabled
  tags = merge(var.tags, {
    "Environment" = var.env,
    "Name"        = "${var.cluster_identifier}-instance-${count.index}"
  })
}
