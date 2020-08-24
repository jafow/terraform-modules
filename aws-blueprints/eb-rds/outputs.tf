output "public_subnet_cidrs" {
  value = module.network.public_subnet_cidrs
}

output "private_subnet_cidrs" {
  value = module.network.private_subnet_cidrs
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}
output "vpc_cidr" {
  value = module.network.vpc_cidr
}

output "igw_id" {
  value       = module.network.igw_id
  description = "The ID of the Internet Gateway"
}

output "vpc_id" {
  value       = module.network.vpc_id
  description = "The ID of the VPC"
}

output "public_route_table_ids" {
  description = "IDs of the created public route tables"
  value       = module.network.public_route_table_ids
}

output "private_route_table_ids" {
  description = "IDs of the created private route tables"
  value       = module.network.private_route_table_ids
}

output "nat_gateway_ids" {
  description = "IDs of the NAT Gateways created"
  value       = module.network.nat_gateway_ids
}

output "nat_instance_ids" {
  description = "IDs of the NAT Instances created"
  value       = module.network.nat_instance_ids
}

output "availability_zones" {
  description = "List of Availability Zones where subnets were created"
  value       = var.availability_zones
}

output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}
