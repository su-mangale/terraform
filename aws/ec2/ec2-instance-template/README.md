# EC2 Instance Template

This Terraform snippet provisions a single Amazon Linux 2 EC2 instance and returns its IP addresses. It assumes your AWS CLI/credentials are already configured (the module optionally accepts an explicit region override).

## Usage

```hcl
module "ec2_instance" {
  source               = "./aws/ec2-instance-template"
  subnet_id            = "subnet-0123456789abcdef0"
  security_group_ids   = ["sg-0123456789abcdef0"]
  instance_type        = "t3.micro"
  instance_name        = "demo-instance"
  key_name             = "my-keypair"
  associate_public_ip  = true
  aws_region           = "us-east-1" # optional; omit to use CLI default
}
```

Then run:

```bash
terraform init
terraform plan -target=module.ec2_instance
terraform apply -target=module.ec2_instance
terraform output -json
```

## Inputs

See [variables.tf](variables.tf) for the full list. At minimum you must supply:

- `subnet_id`
- `security_group_ids`

Optional inputs let you override the AMI, region, key pair, tags, and whether to attach a public IP.

## Outputs

- `instance_id`
- `public_ip`
- `private_ip`

These outputs make it easy to feed the instance address into follow-on automation.
