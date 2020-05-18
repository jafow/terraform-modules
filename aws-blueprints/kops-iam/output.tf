output "id" {
  value = aws_iam_group.group.id
}

output "arn" {
  value = aws_iam_group.group.arn
}

output "group_name" {
  value = aws_iam_group.group.name
}

output "path_name" {
  value = aws_iam_group.group.path
}

output "uid" {
  value = aws_iam_group.group.unique_id
}

output "iam_user_arn" {
  value = aws_iam_user.kops.arn
}

output "iam_user_key_id" {
  value = aws_iam_access_key.kops.id
}

output "iam_user_key_secret" {
  value = aws_iam_access_key.kops.secret
}

output "key_name" {
  value = aws_key_pair.ec2.key_name
}

output "key_id" {
  value = aws_key_pair.ec2.key_pair_id
}
