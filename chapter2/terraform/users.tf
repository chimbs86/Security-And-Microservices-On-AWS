module "user" {
  source = "../../lib/iam_user"
  name = "gaurav"
  policy_file = "policy.json"
}