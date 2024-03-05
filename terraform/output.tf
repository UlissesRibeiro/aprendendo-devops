output "ip_address" {
  value = aws_instance.webserver_lab.public_ip
}