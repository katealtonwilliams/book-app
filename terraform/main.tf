resource "aws_iam_role" "lambda_role" {
    name = "terraform_aws_lambda_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Sid": "",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
    name        = "aws_iam_policy_for_terraform_aws_lambda_role"
    path        = "/"
    description = "AWS IAM policy for managing aws lambda role"
    policy      = <<EOF
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

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

data "archive_file" "zip_the_python_code" {
  type = "zip"
  source_dir  = "${path.module}/python_backend/lambdas"
  output_path = "${path.module}/python_backend/lambdas/hello_word.zip"
}

resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/python_backend/lambdas/hello_word.zip"
  function_name = "first-lambda-function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "hello_world.lambda_handler"
  runtime       = "python3.13"
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

output "terraform_aws_role_output" {
  value = aws_iam_role.lambda_role.name
}

output "terraform_aws_role_arn_output" {
  value = aws_iam_role.lambda_role.arn
}

output "terraform_logging_arn_output" {
  value = aws_iam_policy.iam_policy_for_lambda.arn
}

