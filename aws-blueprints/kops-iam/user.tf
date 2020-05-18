resource "aws_iam_user" "kops" {
  name = var.user_name
  path = var.path_name
}

resource "aws_iam_access_key" "kops" {
  user = aws_iam_user.kops.name
}

resource "aws_iam_group_membership" "kops" {
  name = "${var.group_name}-member"

  users = [
    aws_iam_user.kops.name
  ]

  group = aws_iam_group.group.name
}

