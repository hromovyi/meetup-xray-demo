resource "aws_iam_role" "lambda_role" {
  name               = "${local.function_name}-role"
  path               = "/"
  description        = "Application role for ${local.function_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "s3_access_policy" {
  name   = "S3AccessPolicy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.s3_access_policy_document.json
}

data "aws_iam_policy_document" "s3_access_policy_document" {
  statement {
    actions   = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "aws_xray_write_only_access" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "vpc_access_execution_policy" {
  role       = aws_iam_role.lambda_role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}