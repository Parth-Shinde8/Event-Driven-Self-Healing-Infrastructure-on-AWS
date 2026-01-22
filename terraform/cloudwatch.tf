resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aiops/app"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "system_logs" {
  name              = "/aiops/system"
  retention_in_days = 7
}
