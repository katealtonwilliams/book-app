provider "aws" {
  region = "eu-west-2"
}

resource "aws_iam_role" "lambda_role" {
  name = "terraform_aws_lambda_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name        = "aws_iam_policy_for_terraform_aws_lambda_role"
  path        = "/"
  description = "AWS IAM policy for managing aws lambda role"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "s3:GetObject",
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ],
        "Resource" : ["arn:aws:logs:*:*:*",
        "arn:aws:s3:::terraform-state-bucket-aebb0499259047588b07a8b0382e8026"]
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}


resource "aws_lambda_function" "terraform_lambda_func" {
  s3_bucket     = "terraform-state-bucket-aebb0499259047588b07a8b0382e8026"
  s3_key        = ""
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

