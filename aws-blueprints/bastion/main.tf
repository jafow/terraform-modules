locals {
  bastion_name = "bastion-${var.account_id}-${var.stage}"
}

resource "aws_route53_record" "hostname" {
  count = tobool(var.enable_bastion_hostname) ? 1 : 0
  zone_id = var.hosted_zone_id
  name = var.bastion_hostname
  type = "A"
  ttl = 120
  records = [aws_eip.eip.public_ip]
}

resource "aws_key_pair" "bastion" {
  key_name   = var.key_name
  public_key = var.public_key
}

data "aws_ami" "ami" {
  owners      = ["137112412989"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*.x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}


resource "aws_iam_instance_profile" "s3_readonly" {
  name = "s3_readonly"
  role = aws_iam_role.s3_readonly.name
}

resource "aws_iam_role" "s3_readonly" {
  name = "s3_readonly"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "s3_readonly_policy" {
  statement {
    sid = "S3ReadOnlyPublicKey"
    actions = [
      "s3:List*",
      "s3:Get*",
      "ec2:AssociateAddress"
    ]
    resources = [aws_s3_bucket.ssh_public_keys.arn, "*"]
  }
}

resource "aws_iam_role_policy" "s3_readonly_policy" {
  name = "s3_readonly-policy"
  role = aws_iam_role.s3_readonly.id

  policy = data.aws_iam_policy_document.s3_readonly_policy.json
}

resource "aws_eip" "eip" {
  vpc = true
}


module "bastion" {
  source                      = "git::https://github.com/terraform-community-modules/tf_aws_bastion_s3_keys?ref=tags/v2.0.0"
  instance_type               = var.bastion_instance_type
  ami                         = data.aws_ami.ami.id
  eip                         = aws_eip.eip.public_ip
  region                      = var.region
  iam_instance_profile        = "s3_readonly"
  s3_bucket_name              = aws_s3_bucket.ssh_public_keys.id
  vpc_id                      = var.vpc_id
  subnet_ids                  = var.subnet_ids
  keys_update_frequency       = var.cron_key_update_schedule 
  enable_hourly_cron_updates  = true
  apply_changes_immediately   = true
  associate_public_ip_address = true
  ssh_user                    = "ec2-user"
  key_name                    = aws_key_pair.bastion.key_name
  allowed_security_groups     = var.allowed_security_groups
  additional_user_data_script = <<EOF
printf "COMPUTER TOWN\n"
printf "============================\n"
printf "============================\n"
printf "============================\n"
printf "============================\n"
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
aws ec2 associate-address --region $REGION --instance-id $INSTANCE_ID --allocation-id ${aws_eip.eip.id}
EOF
}

resource "aws_s3_bucket" "ssh_public_keys" {
  bucket        = local.bastion_name
  acl           = "private"
  force_destroy = true

  policy = <<EOF
{
	"Version": "2008-10-17",
	"Id": "${local.bastion_name}-Policy",
	"Statement": [
		{
			"Sid": "GetPublicKeys",
			"Effect": "Allow",
			"Principal": {
				"AWS": [
				  "arn:aws:iam::${var.account_id}:root"
        ]
			},
			"Action": [
				"s3:List*",
				"s3:Get*"
			],
			"Resource": "arn:aws:s3:::${local.bastion_name}"
		}
	]
}
EOF
}

resource "aws_s3_bucket_object" "ssh_public_keys" {
  count = length(var.ssh_public_key_names)

  bucket = aws_s3_bucket.ssh_public_keys.bucket
  key    = "${element(var.ssh_public_key_names, count.index)}.pub"

  # Make sure that you put files into correct location and name them accordingly (`public_keys/{keyname}.pub`)
  source = "public_keys/${element(var.ssh_public_key_names, count.index)}.pub"

  depends_on = [aws_s3_bucket.ssh_public_keys]
}

