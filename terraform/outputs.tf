output "app_server_ip" {
  value = aws_instance.app_server.public_ip
}
output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}
