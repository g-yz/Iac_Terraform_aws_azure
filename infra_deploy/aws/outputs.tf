output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "web_url" {
  description = "Web URL of the app"
  value       = "http://${aws_instance.web.public_ip}"
}
