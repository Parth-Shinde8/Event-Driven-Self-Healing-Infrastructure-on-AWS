############################################
# PACKAGE LAMBDA CODE
############################################

data "archive_file" "aiops_lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda"
  output_path = "${path.module}/aiops_lambda.zip"
}

############################################
# LAMBDA FUNCTION
############################################

resource "aws_lambda_function" "aiops" {
  function_name = "aiops-self-healing"
  runtime       = "python3.10"
  handler       = "lambda_aiops.lambda_handler"

  filename         = data.archive_file.aiops_lambda_zip.output_path
  source_code_hash = data.archive_file.aiops_lambda_zip.output_base64sha256

  role    = aws_iam_role.lambda_role.arn
  timeout = 30

  depends_on = [
    aws_iam_role_policy_attachment.lambda_attach
  ]
}
