resource "aws_iam_group" "group" {
  name = var.group_name
  path = var.path_name
}

data "aws_iam_policy" "ec2" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

data "aws_iam_policy" "route53" {
  arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

data "aws_iam_policy" "s3" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "iam" {
  arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

data "aws_iam_policy" "vpc" {
  arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_group_policy_attachment" "ec2-attach" {
  group      = aws_iam_group.group.name
  policy_arn = data.aws_iam_policy.ec2.arn

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_group_policy_attachment" "route53-attach" {
  group      = aws_iam_group.group.name
  policy_arn = data.aws_iam_policy.route53.arn
}

resource "aws_iam_group_policy_attachment" "s3-attach" {
  group      = aws_iam_group.group.name
  policy_arn = data.aws_iam_policy.s3.arn
}

resource "aws_iam_group_policy_attachment" "iam-attach" {
  group      = aws_iam_group.group.name
  policy_arn = data.aws_iam_policy.iam.arn
}

resource "aws_iam_group_policy_attachment" "vpc-attach" {
  group      = aws_iam_group.group.name
  policy_arn = data.aws_iam_policy.vpc.arn
}

resource "aws_key_pair" "ec2" {
  key_name_prefix = "${var.stage}-${var.region}-${var.group_name}"
  public_key      = var.public_key
}

