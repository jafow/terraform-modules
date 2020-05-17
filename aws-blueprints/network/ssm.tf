
resource "aws_ssm_parameter" "private_subnet_cidrs" {
  name = "${var.stage}/{var.region}/private_subnet_cidrs"
  description = "private subnet cidr"
  type = "SecureString"
  value = join(",", module.subnets.private_subnet_cidrs)

  tags = var.tags
}

resource "aws_ssm_parameter" "public_subnet_cidrs" {
  name = "${var.stage}/{var.region}/public_subnet_cidrs"
  description = "public subnet cidr"
  type = "SecureString"
  value = join(",", module.subnets.public_subnet_cidrs)

  tags = var.tags
}

