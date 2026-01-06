# S3 Object CRUD IAM Policy

This Terraform configuration provisions an IAM user and attaches a policy limiting access to a single S3 bucket. The policy only allows the user to Get, Put, and Delete objects inside the specified bucket in line with the requested security posture.

## Inputs

- `aws_region`: AWS region for the provider.
- `bucket_name`: Name of the existing S3 bucket to control.
- `iam_user_name`: Friendly name for the IAM user (defaults to `s3-object-operator`).
- `extra_tags`: Optional map of supplementary tags merged onto the IAM user.

## Usage

```hcl
module "s3_object_crud" {
  source        = "./aws/s3/policies"
  aws_region    = "us-east-1"
  bucket_name   = "my-existing-bucket"
  iam_user_name = "bucket-crud-user"
}
```

After `terraform apply`, share the resulting credentials for `iam_user_name` with the operator who needs tightly scoped S3 object CRUD access.

## Validation

- `terraform fmt` and `terraform validate` should pass before committing.
- Use `aws iam simulate-custom-policy --policy-input-list file://policy.json` if you need to confirm the final permissions outside Terraform.
