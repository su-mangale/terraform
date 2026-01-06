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

variable "security_group_ids" {
  description = "List of security group IDs to associate with the instance."
  type        = list(string)
}

variable "key_name" {
  description = "Existing EC2 key pair to attach. Leave empty to skip SSH access."
  type        = string
  default     = ""
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
