############################################
# IAM ROLE FOR APP SERVER EC2
############################################

resource "aws_iam_role" "app_ec2_role" {
  name = "aiops-app-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "app_ec2_policy" {
  name = "aiops-app-ec2-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:*",
          "logs:*",
          "ec2:Describe*",
          "ec2-instance-connect:SendSSHPublicKey"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "app_ec2_attach" {
  role       = aws_iam_role.app_ec2_role.name
  policy_arn = aws_iam_policy.app_ec2_policy.arn
}

resource "aws_iam_instance_profile" "app_ec2_profile" {
  name = "aiops-app-instance-profile"
  role = aws_iam_role.app_ec2_role.name
}

############################################
# IAM ROLE FOR AIOPS LAMBDA
############################################

resource "aws_iam_role" "lambda_role" {
  name = "aiops-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "aiops-lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "ec2:RebootInstances",
          "ec2:DescribeInstances",
          "sns:Publish"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
