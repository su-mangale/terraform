# EC2 Instance Template

This Terraform snippet provisions a single Amazon Linux 2 EC2 instance and returns its IP addresses. It assumes your AWS CLI/credentials are already configured (the module optionally accepts an explicit region override).

## Usage

```hcl
module "ec2_instance" {
  source               = "./aws/ec2/ec2-instance-template"
  subnet_id            = "subnet-0123456789abcdef0"
  additional_security_group_ids = []    # optional
  instance_type        = "t3.micro"
  instance_name        = "demo-instance"
  key_pair_name        = "demo-instance-key"
  associate_public_ip  = true
  aws_region           = "us-east-1" # optional; omit to use CLI default
}
```

Then run:

```bash
terraform init
terraform plan -target=module.ec2_instance
terraform apply -target=module.ec2_instance
terraform output -json > outputs.json # capture instance info + generated key material
```

## Inputs

See [variables.tf](variables.tf) for the full list. At minimum you must supply:

- `subnet_id`

Optional inputs let you override the AMI, region, generated key pair name, ingress CIDRs, tags, and whether to attach a public IP. You can also attach extra security groups via `additional_security_group_ids`.

## Outputs

- `instance_id`
- `public_ip`
- `private_ip`
- `security_group_id`
- `ssh_private_key_pem` (sensitive)
- `ssh_public_key_openssh` (sensitive)

Store the private key securely immediately after `terraform apply`; Terraform keeps it in state, but you are responsible for distributing it to operators or automation that need SSH access. The generated security group allows ports 22/80/443 from the IPv4/IPv6 CIDRs you define (defaults are the entire internet).
