output connection_id {
  value = module.peering_connection.peering_connection_id
}

output vpc_id {
  value = module.peering_connection.requester_vpc_id
}

output peer_vpc_id {
  value = module.peering_connection.peer_vpc_id
}
