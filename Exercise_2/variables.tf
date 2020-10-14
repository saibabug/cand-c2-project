# TODO: Define the variable for aws_region

variable "region" {
  default = "us-east-2"
}

variable "function_name" {
  default = "greet_lambda"
}


variable "lambda_output_path" {
  default = "output.zip"
}