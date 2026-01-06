output "iam_user_name" {
  description = "IAM user granted object-level CRUD permissions on the target bucket."
  value       = aws_iam_user.s3_object_operator.name
}

output "policy_arn" {
  description = "ARN of the IAM policy that restricts access to object-level operations."
  value       = aws_iam_policy.s3_object_crud.arn
}
