resource "aws_lambda_function" "function" {
  filename      = "${path.root}/../${local.function_name}/build/${local.distribution_name}.zip"
  function_name = local.function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "src/index.handler"
  runtime       = "nodejs12.x"
  timeout       = "10"
  depends_on    = [
    aws_cloudwatch_log_group.log_group,
    null_resource.build_script
  ]

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      SNS_TOPIC_ARN          = var.sns_topic_arn
      ATTRIBUTES_MANAGER_URL = var.attributes_manager_url
      AWS_XRAY_LOG_LEVEL     = "silent"
    }
  }
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${local.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.sqs_queue_arn
  function_name    = aws_lambda_function.function.function_name
  enabled          = true
}

resource "aws_lambda_permission" "sqs_trigger_permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.function.function_name
  principal     = "sqs.amazonaws.com"
  source_arn    = var.sqs_queue_arn
}
