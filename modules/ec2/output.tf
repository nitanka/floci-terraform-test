output "id" {
    description = "The ID of the instance"
    value       = try(module.ec2_instance[0].id, null)
}

output "arn" {
    description = "The ARN of the instance"
    value       = try(module.ec2_instance[0].arn, null)
}

output "private_ip" {
    description = "The private IP address of the instance"
    value       = try(module.ec2_instance[0].private_ip, null)
}

output "public_ip" {
    description = "The public IP address of the instance"
    value       = try(module.ec2_instance[0].public_ip, null)
}

output "key_name" {
    description = "The name of the generated key pair"
    value       = try(aws_key_pair.ec2[0].key_name, null)
}

output "private_key_pem" {
    description = "PEM-encoded private key for the generated key pair. Push this to Vault/Secrets Manager immediately after apply — do not write it to disk."
    value       = try(tls_private_key.ec2[0].private_key_pem, null)
    sensitive   = true
}
