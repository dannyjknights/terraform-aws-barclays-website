output "ec2_fqdn" {
  value = aws_instance.web_instance.public_dns
}