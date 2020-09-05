variable allowed_security_groups {
  type = list
  default = []
}

variable subnet_ids {
  type = list
  default = []
}

variable key_name { 
  default = "bastion"
}
variable public_key {}

variable bastion_instance_type {
  default = "t2.small"
}

variable account_id {}

variable ssh_public_key_names {
  type    = list(string)
  default = []
}

variable stage {}

variable vpc_id {}

variable enable_bastion_hostname {}
variable hosted_zone_id {}
variable bastion_hostname {}
variable region {}

variable cron_key_update_schedule {
  default = "5,0,*,* * * * *"
}
