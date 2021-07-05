module "attributes_manager" {
  source = "./attributes-manager"

  region = var.region
}

module "event_enricher" {
  source = "./event-enricher"

  sns_topic_arn          = aws_sns_topic.topic.arn
  sqs_queue_arn          = aws_sqs_queue.queue.arn
  attributes_manager_url = module.attributes_manager.website_url
}

module "event_persist" {
  source = "./event-persist"

  bucket_name   = aws_s3_bucket.bucket.bucket
  sns_topic_arn = aws_sns_topic.topic.arn
}