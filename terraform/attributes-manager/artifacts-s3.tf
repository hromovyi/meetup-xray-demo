resource "aws_s3_bucket" "eb_artifacts" {
  bucket = "meetup-xray-demo-eb-artifacts"
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