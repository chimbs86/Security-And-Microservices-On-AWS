resource "aws_iam_user" "test_user" {
  name = "test_user"
}

resource "aws_iam_user_policy" "test_user" {
  name = "test"
  user = aws_iam_user.test_user.name

  policy = file("policy.json")
}