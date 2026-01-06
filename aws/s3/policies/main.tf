terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_iam_user" "s3_object_operator" {
  name          = var.iam_user_name
  force_destroy = false

  tags = merge(
    {
      ManagedBy = "terraform"
      Purpose   = "s3-object-crud"
    },
    var.extra_tags,
  )
}

data "aws_iam_policy_document" "s3_object_crud" {
  statement {
    sid    = "S3ObjectCrudAccess"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}",
      "arn:aws:s3:::${var.bucket_name}/*",
    ]
  }
}

resource "aws_iam_policy" "s3_object_crud" {
  name        = "${var.iam_user_name}-s3-object-crud"
  description = "Permit get/put/delete object level access for bucket ${var.bucket_name}"
  policy      = data.aws_iam_policy_document.s3_object_crud.json
}

resource "aws_iam_user_policy_attachment" "s3_object_crud" {
  user       = aws_iam_user.s3_object_operator.name
  policy_arn = aws_iam_policy.s3_object_crud.arn
}
