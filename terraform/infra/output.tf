output "ec2_public_ips" {
  value       = aws_instance.my_instance[*].public_ip
  description = "Public IP addresses of AWS EC2 instances"
}