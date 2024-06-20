resource "aws_iam_role" "lambda_role" {
  count = var.enable_lambda ? 1 : 0
  name  = var.lambda_role_name

  assume_role_policy = jsonencode({
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
  })
}

resource "aws_iam_role_policy" "lambda_role_policy" {
  count = var.enable_lambda ? 1 : 0
  name   = "LambdaEC2NetworkInterfacePolicy"
  role   = aws_iam_role.lambda_role[0].name 

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_lambda_function" "terraform_lambda_func" {
  count         = var.enable_lambda ? 1 : 0
  filename      = var.lambda_filename
  function_name = var.lambda_func_name
  role          = aws_iam_role.lambda_role[0].arn
  handler       = var.lambdas_handler
  runtime       = var.lambda_runtime
  vpc_config {
    subnet_ids         = var.vpc_subnets
    security_group_ids = var.vpc_sgs
  }
}
