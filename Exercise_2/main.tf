provider "aws" {
  profile = "default"
  shared_credentials_file = "/Users/venkatagarimella/.aws/credentials"
  region = "us-east-2"
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name  = "/aws/lambda/${var.function_name}"
  retention_in_days = 1
}


resource "aws_iam_policy" "lambda_logging_policy" {
  name = "lambda_logging"
  path = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}



resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda_exec_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


data "archive_file" "lambda_zip" {
    type = "zip"
    source_file = "greet_lambda.py"
    output_path = var.lambda_output_path
}

resource "aws_lambda_function" "hellofunc_lambda" {
  description      = "Python lambda for Udacity project 2 Task 2"
  role             = aws_iam_role.iam_for_lambda.arn
  filename         = "lambdascript.zip"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  function_name    = var.function_name
  handler          = "${var.function_name}.lambda_handler"
  runtime          = "python3.8"

  environment {
    variables = {
      Name = "Lambda's Hello world "
    }
  }

  depends_on = [aws_cloudwatch_log_group.lambda_log_group, aws_iam_role_policy_attachment.lambda_logs]
}
