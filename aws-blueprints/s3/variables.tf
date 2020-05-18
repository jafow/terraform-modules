variable "bucket_name" {
  type = string
  default = "change-me"
}

variable "kms_master_key_arn" {
  type = string
  description = "arn of an existing kms key to use for sse"
  default = ""
}

variable "sse_enabled" {
  type = bool
  default = true
}

variable "sse_algorithm" {
  type = string
  description = "server side encryption algorithm; default to aws:kms"
  default = "aws:kms"
}

variable "deletion_window_in_days" {
  type = number
  default = 30
}

variable tags {
  type = map
  default = {}
}

variable "bucket_principal_arn" {
  default = "*"
}
