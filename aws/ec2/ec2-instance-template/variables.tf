variable "aws_region" {
  description = "Optional AWS region override. Leave empty to use the CLI/profile default."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "EC2 instance type to launch."
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched."
  type        = string
}

variable "key_pair_name" {
  description = "Name for the AWS key pair that Terraform will create and attach to the instance."
  type        = string
  default     = "ec2-instance-template-key"
}

variable "additional_security_group_ids" {
  description = "Optional extra security groups to attach alongside the generated group."
  type        = list(string)
  default     = []
}

variable "ingress_cidr_blocks" {
  description = "IPv4 CIDRs allowed to access ports 22/80/443."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ingress_ipv6_cidr_blocks" {
  description = "IPv6 CIDRs allowed to access ports 22/80/443. Use an empty list to disable IPv6 ingress."
  type        = list(string)
  default     = ["::/0"]
}

variable "associate_public_ip" {
  description = "Whether to assign a public IP."
  type        = bool
  default     = true
}

variable "instance_name" {
  description = "Value for the Name tag."
  type        = string
  default     = "ec2-instance-template"
}

variable "extra_tags" {
  description = "Additional tags merged into every resource."
  type        = map(string)
  default     = {}
}

variable "instance_tags" {
  description = "Instance-specific tags merged on top of base tags."
  type        = map(string)
  default     = {}
}

variable "custom_ami_id" {
  description = "Optional explicit AMI ID. Leave empty to auto-select Amazon Linux 2."
  type        = string
  default     = ""
}
