variable vpc_id {
  description = "the vpc id of the requester"
}

variable peer_vpc_id {
  description = "the vpc id of the peer vpc to be linked to"
}

variable tags {
  type = map
  default = {}
}

variable region {}
variable stage {}
variable namespace {}
