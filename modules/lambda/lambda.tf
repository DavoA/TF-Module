resource "aws_iam_role" "lambda_role" {
  count = var.enable_lambda ? 1 : 0
  name = "lambda_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_lambda_function" "terraform_lambda_func" {
  count = var.enable_lambda ? 1 : 0
  filename      = "${path.module}/python/hello.zip"
  function_name = "My-Python-Lambda-Function"
  role          = aws_iam_role.lambda_role[0].arn
  handler       = "hello.lambda_handler"
  runtime       = "python3.8"
  vpc_config {
    subnet_ids         = var.vpc_subnets
    security_group_ids = var.vpc_sgs
  }
}
