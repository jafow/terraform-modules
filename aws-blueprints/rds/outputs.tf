output "db_subnet_group_name" {
  value = aws_db_subnet_group.default.id
}

output "db_instance_hostname" {
  value = aws_db_instance.default.address
}

output "db_instance_arn" {
  value = aws_db_instance.default.arn
}

output "db_engine_version" {
  value = aws_db_instance.default.engine_version
}

output "db_instance_name" {
  value = aws_db_instance.default.name
}

output "db_storage_encrypted" {
  value = aws_db_instance.default.storage_encrypted
}
