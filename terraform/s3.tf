resource "aws_s3_bucket" "bucket" {
  bucket = "meetup-xray-demo-events"
  acl    = "private"
}