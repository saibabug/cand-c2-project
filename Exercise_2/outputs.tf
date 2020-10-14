# TODO: Define the output variable for the lambda function.
output "lambda_function_arn" {
  description = "The ARN of the Lambda function"
  value = "${aws_lambda_function.greeting_lambda.arn}"
}
