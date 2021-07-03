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

# Attach a policy required to trigger lambda execution by SQS
data "aws_iam_policy_document" "sqs" {
  statement {
    effect = "Allow"

    actions = [
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage",
      "sqs:GetQueueAttributes"
    ]

    resources = [var.sqs_queue_arn]
  }
}

resource "aws_iam_role_policy" "sqs" {
  name   = "${local.function_name}-sqs"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.sqs.json
}

resource "aws_iam_role_policy" "sns_access_policy" {
  name   = "SnsAccessPolicy"
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.sns_access_policy_document.json
}

data "aws_iam_policy_document" "sns_access_policy_document" {
  statement {
    actions   = [
      "sns:Publish",
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