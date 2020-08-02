variable database_name {
  description = "name of the primary database schema created on the instance"
  default     = "default"
}

variable database_username {
  description = "main username created on db instance"
  default     = "default"
}

variable allow_major_version_upgrade {
  type        = bool
  default     = true
  description = "allows automatic update to the db software"
}

variable iam_database_authentication_enabled {
  type        = bool
  default     = true
  description = "allow auth to db via IAM roles"
}

variable instance_class {
  description = "the compute instance type to use"
  default     = "db.t2.micro"
}

variable identifier_prefix {
  description = "name of the RDS instance"
  default     = ""
}

variable param_group {
  description = "the name of the parameter group assigned"
  default     = "default.mysql5.7"
}

variable final_snapshot_identifier {
  description = "the name of the db snapshot created when db is deleted"
  default     = "final-snapshot"
}

variable vpc_security_group_ids {
  type        = list
  description = "list of permitted security groups to associate with this db instance"
  default     = []
}

variable backup_retention_period {
  description = "how long to retain backups after db is removed; default to 5"
  default     = 5
}

variable db_subnet_group_name {
  description = "the name of the db subnet group to create the db in; see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group"
  default     = "default"
}

variable private_subnet_ids {
  description = "ids for private subnets in vpc"
  type        = list
  default     = []
}

variable "storage_encrypted" {
  description = "if storage is encrypted at rest"
  type = bool
  default = true
}

variable ssm_path {}
variable tags {
  type    = map
  default = {}
}
