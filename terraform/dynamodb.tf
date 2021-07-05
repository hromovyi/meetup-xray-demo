resource "aws_dynamodb_table" "hotels" {
  hash_key     = "uuid"
  name         = "Meetup-XRay-demo-Hotels"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "uuid"
    type = "S"
  }
}

resource "aws_dynamodb_table" "rooms" {
  hash_key     = "hotelUuid"
  range_key    = "uuid"
  name         = "Meetup-XRay-demo-Rooms"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "hotelUuid"
    type = "S"
  }

  attribute {
    name = "uuid"
    type = "S"
  }
}

### test data configuration
resource "aws_dynamodb_table_item" "hotel1" {
  table_name = aws_dynamodb_table.hotels.name
  hash_key   = aws_dynamodb_table.hotels.hash_key

  item = <<ITEM
  {
    "uuid": {"S": "12345"},
    "name": {"S": "Hotel Riu"},
    "address": {"S": "Demoville, Demo avenue, 1"},
    "viewType": {"S": "SEA_VIEW"}
  }
  ITEM
}
resource "aws_dynamodb_table_item" "hotel1_room1" {
  table_name = aws_dynamodb_table.rooms.name
  hash_key   = aws_dynamodb_table.rooms.hash_key
  range_key  = aws_dynamodb_table.rooms.range_key

  item = <<ITEM
  {
    "uuid": {"S": "12345_1"},
    "hotelUuid": {"S": "12345"},
    "name": {"S": "Large Presidental Suite"},
    "occupancy": {"N": "5"}
  }
  ITEM
}
resource "aws_dynamodb_table_item" "hotel1_room2" {
  table_name = aws_dynamodb_table.rooms.name
  hash_key   = aws_dynamodb_table.rooms.hash_key
  range_key  = aws_dynamodb_table.rooms.range_key

  item = <<ITEM
  {
    "uuid": {"S": "12345_2"},
    "hotelUuid": {"S": "12345"},
    "name": {"S": "Single-bedroom suite"},
    "occupancy": {"N": "2"}
  }
  ITEM
}

resource "aws_dynamodb_table_item" "hotel2" {
  table_name = aws_dynamodb_table.hotels.name
  hash_key   = aws_dynamodb_table.hotels.hash_key

  item = <<ITEM
  {
    "uuid": {"S": "23456"},
    "name": {"S": "Hotel Blue"},
    "address": {"S": "Demoville, Demo avenue, 2"},
    "viewType": {"S": "GARDEN_VIEW"}
  }
  ITEM
}
resource "aws_dynamodb_table_item" "hotel2_room1" {
  table_name = aws_dynamodb_table.rooms.name
  hash_key   = aws_dynamodb_table.rooms.hash_key
  range_key  = aws_dynamodb_table.rooms.range_key

  item = <<ITEM
  {
    "uuid": {"S": "23456_1"},
    "hotelUuid": {"S": "23456"},
    "name": {"S": "Double-bedroom suite"},
    "occupancy": {"N": "4"}
  }
  ITEM
}
resource "aws_dynamodb_table_item" "hotel2_room2" {
  table_name = aws_dynamodb_table.rooms.name
  hash_key   = aws_dynamodb_table.rooms.hash_key
  range_key  = aws_dynamodb_table.rooms.range_key

  item = <<ITEM
  {
    "uuid": {"S": "23456_2"},
    "hotelUuid": {"S": "23456"},
    "name": {"S": "Single room"},
    "occupancy": {"N": "1"}
  }
  ITEM
}
resource "aws_dynamodb_table_item" "hotel2_room3" {
  table_name = aws_dynamodb_table.rooms.name
  hash_key   = aws_dynamodb_table.rooms.hash_key
  range_key  = aws_dynamodb_table.rooms.range_key

  item = <<ITEM
  {
    "uuid": {"S": "23456_3"},
    "hotelUuid": {"S": "23456"},
    "name": {"S": "Penthouse"},
    "occupancy": {"N": "50"}
  }
  ITEM
}