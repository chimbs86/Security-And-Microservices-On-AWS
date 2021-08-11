resource "aws_iam_user" "user" {
  name = var.name
}

resource "aws_iam_user_policy" "user" {
  name = "policy_${var.name}"
  user = aws_iam_user.user.name

  policy = var.policy_json
}