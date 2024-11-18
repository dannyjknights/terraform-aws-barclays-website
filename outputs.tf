output "website_address" {
  value = aws_instance.web_instance.public_dns
}