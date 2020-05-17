variable "main_zone_name" {
  type = string
}

variable "sub_dns_name" {
  type = string
}

variable tags {
  type    = map
  default = {}
}
