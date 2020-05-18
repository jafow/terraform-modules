variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  type = list
  default = []
}

variable "ttl" {
  description = "dns time to live"
  type = string
  default = 300
}

variable "route53_zone_name" {
  type = string
}

variable "enabled" {
  type = bool
  default = true
}

variable "tags" {
  type = map
  default = {}
}
