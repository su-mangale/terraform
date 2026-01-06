terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region != "" ? var.aws_region : null
}

locals {
  base_tags = merge(
    {
      ManagedBy = "terraform"
      Purpose   = "ec2-instance-template"
    },
    var.extra_tags,
  )
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

resource "aws_security_group" "instance" {
  name        = "${var.instance_name}-sg"
  description = "Allow SSH/HTTP/HTTPS ingress from the internet"
  vpc_id      = data.aws_subnet.selected.vpc_id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks
    ipv6_cidr_blocks = var.ingress_ipv6_cidr_blocks
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    local.base_tags,
    {
      Name = "${var.instance_name}-sg"
    },
  )
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.ssh.public_key_openssh

  tags = merge(
    local.base_tags,
    {
      Name = "${var.instance_name}-key"
    },
  )
}

resource "aws_instance" "this" {
  ami                         = var.custom_ami_id != "" ? var.custom_ami_id : data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = concat([aws_security_group.instance.id], var.additional_security_group_ids)
  associate_public_ip_address = var.associate_public_ip
  key_name                    = aws_key_pair.generated.key_name

  tags = merge(
    local.base_tags,
    var.instance_tags,
    {
      Name = var.instance_name
    },
  )
}
