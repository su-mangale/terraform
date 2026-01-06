variable "aws_region" {
  description = "AWS region where resources will be managed."
  type        = string
}

variable "bucket_name" {
  description = "Existing S3 bucket to which the IAM user should have object-level CRUD access."
  type        = string
}

variable "iam_user_name" {
  description = "Name for the IAM user that will manage S3 objects."
  type        = string
  default     = "s3-object-operator"
}

variable "extra_tags" {
  description = "Optional additional tags to apply to the IAM user."
  type        = map(string)
  default     = {}
}
