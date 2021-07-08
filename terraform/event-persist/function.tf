resource "aws_lambda_function" "function" {
  function_name = local.function_name
  filename      = "${path.root}/../${local.function_name}/build/${local.distribution_name}.zip"
  role          = aws_iam_role.lambda_role.arn
  handler       = "src/index.handler"
  runtime       = "nodejs12.x"
  timeout       = "10"
  depends_on    = [
    aws_cloudwatch_log_group.log_group,
    null_resource.build_script
  ]

  environment {
    variables = {
      BUCKET_NAME        = var.bucket_name
      AWS_XRAY_LOG_LEVEL = "silent"
    }
  }
}

resource "aws_lambda_function_event_invoke_config" "config" {
  function_name          = aws_lambda_function.function.function_name
  maximum_retry_attempts = 0
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${local.function_name}"
  retention_in_days = 30
}

resource "aws_sns_topic_subscription" "sns_trigger" {
  topic_arn = var.sns_topic_arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.function.arn
}

resource "aws_lambda_permission" "sns_trigger_permission" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_topic_arn
}