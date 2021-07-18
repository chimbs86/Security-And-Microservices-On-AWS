resource "aws_dynamodb_table" "test_table" {
  name = "test_table"

  read_capacity  = 1
  write_capacity = 1
  hash_key       = "UUID"

  attribute {
    name = "UUID"
    type = "S"
  }
}
