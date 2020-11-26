resource aws_vpc_peering_connection req {
  vpc_id = var.vpc_id
  peer_vpc_id = var.peer_vpc_id
  auto_accept = true
  tags = var.tags
}
