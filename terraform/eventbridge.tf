############################################
# EVENTBRIDGE RULE (EVERY 5 MINUTES)
############################################

resource "aws_cloudwatch_event_rule" "aiops_schedule" {
  name                = "aiops-every-5-min"
  description         = "Run AIOps Lambda every 5 minutes"
  schedule_expression = "rate(5 minutes)"
}

############################################
# EVENTBRIDGE TARGET → LAMBDA
############################################

resource "aws_cloudwatch_event_target" "aiops_lambda_target" {
  rule      = aws_cloudwatch_event_rule.aiops_schedule.name
  target_id = "aiops-lambda"
  arn       = aws_lambda_function.aiops.arn
}

############################################
# PERMISSION: EVENTBRIDGE → LAMBDA
############################################

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.aiops.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.aiops_schedule.arn
}
