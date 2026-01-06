output "instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "public_ip" {
  description = "Public IPv4 address of the instance (if allocated)."
  value       = aws_instance.this.public_ip
}

output "private_ip" {
  description = "Private IPv4 address of the instance."
  value       = aws_instance.this.private_ip
}

output "security_group_id" {
  description = "ID of the security group created for the instance."
  value       = aws_security_group.instance.id
}

output "ssh_private_key_pem" {
  description = "PEM-encoded private key generated for the instance. Store securely."
  value       = tls_private_key.ssh.private_key_pem
  sensitive   = true
}

output "ssh_public_key_openssh" {
  description = "Public key registered with AWS for the instance."
  value       = tls_private_key.ssh.public_key_openssh
  sensitive   = true
}
