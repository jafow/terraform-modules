variable vpc_name {}
variable region {}
variable tags {
  default = {}
  type = map
}
variable stage {}
variable namespace {}
variable cidr_block {}
variable availability_zones {
  type = list(string)
  default = []
}

variable cluster_name {}

variable container_cpu {
  type = number
  default = 256
}

variable container_memory {
  type = number
  default = 512
}

variable task_name {}

variable domain_name {}
variable subject_alternative_names {
  default = []
  type = list(string)
}

variable ttl {
  default = 60
}

variable dns_zone_name {}

variable enable_tls {
  default = false
}
