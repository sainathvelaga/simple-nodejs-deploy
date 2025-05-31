output "instance_id" {
  value = aws_instance.Dev-instance.id
}
output "instance_ip" {
  value = aws_instance.Dev-instance.public_ip
}