data "aws_ssm_parameter" "RDS_PASSWORD" {
  name = "${var.ssm_path}/RDS_PASSWORD"
}

resource "aws_db_subnet_group" "default" {
  name_prefix = var.database_name
  subnet_ids  = var.private_subnet_ids

  tags = var.tags
}

resource "aws_db_instance" "default" {
  allocated_storage                   = 50
  storage_type                        = "gp2"
  engine                              = "mysql"
  engine_version                      = "5.7"
  instance_class                      = var.instance_class
  name                                = var.database_name
  username                            = var.database_username
  password                            = data.aws_ssm_parameter.RDS_PASSWORD.value
  parameter_group_name                = var.param_group
  identifier_prefix                   = var.identifier_prefix
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  final_snapshot_identifier           = var.final_snapshot_identifier
  vpc_security_group_ids              = var.vpc_security_group_ids
  backup_retention_period             = var.backup_retention_period
  db_subnet_group_name                = aws_db_subnet_group.default.id
  tags                                = var.tags
}
