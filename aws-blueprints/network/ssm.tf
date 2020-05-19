
resource "aws_ssm_parameter" "private_subnet_cidrs" {
  name        = "/${var.stage}/${var.region}/private_subnet_cidrs"
  description = "private subnet cidr"
  type        = "SecureString"
  value       = join(",", module.subnets.private_subnet_cidrs)

  tags = var.tags
}

resource "aws_ssm_parameter" "public_subnet_cidrs" {
  name        = "/${var.stage}/${var.region}/public_subnet_cidrs"
  description = "public subnet cidr"
  type        = "SecureString"
  value       = join(",", module.subnets.public_subnet_cidrs)

  tags = var.tags
}

resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.stage}/${var.region}/vpc_id"
  description = "vpc id"
  type        = "String"
  value       = module.vpc.vpc_id

  tags = var.tags
}

resource "aws_ssm_parameter" "igw_id" {
  name        = "/${var.stage}/${var.region}/igw_id"
  description = "vpc id"
  type        = "String"
  value       = module.vpc.igw_id

  tags = var.tags
}

resource "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/${var.stage}/${var.region}/private_subnet_ids"
  description = "private subnet cidr"
  type        = "SecureString"
  value       = join(",", module.subnets.private_subnet_ids)

  tags = var.tags
}

resource "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/${var.stage}/${var.region}/public_subnet_ids"
  description = "public subnet cidr"
  type        = "SecureString"
  value       = join(",", module.subnets.public_subnet_ids)
  tags        = var.tags
}


