locals {
  vpc_tags = merge({ terraform_managed = true, Name = "${var.namespace}-${var.stage}-${var.region}-peering"}, var.tags)
}

module "peering_connection" {
  source      = "../../modules/peering-connection"
  vpc_id      = var.vpc_id
  peer_vpc_id = var.peer_vpc_id
  tags        = local.vpc_tags
}
