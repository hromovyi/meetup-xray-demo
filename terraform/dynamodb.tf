#resource "aws_dynamodb_table" "hotels" {
#  hash_key     = "uuid"
#  name         = "Meetup-XRay-demo-Hotels"
#  billing_mode = "PAY_PER_REQUEST"
#
#  attribute {
#    name = "uuid"
#    type = "S"
#  }
#}
#
#resource "aws_dynamodb_table" "rooms" {
#  hash_key     = "hotelUuid"
#  range_key    = "uuid"
#  name         = "Meetup-XRay-demo-Rooms"
#  billing_mode = "PAY_PER_REQUEST"
#
#  attribute {
#    name = "hotelUuid"
#    type = "S"
#  }
#
#  attribute {
#    name = "uuid"
#    type = "S"
#  }
#}