resource "random_string" "suffix" {
  length  = 10
  upper   = false
  special = false
  number  = false
  lower   = true
}

resource "aws_s3_bucket" "bucket" {
  bucket = "meetup-xray-demo-events-${random_string.suffix.result}"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = true
}