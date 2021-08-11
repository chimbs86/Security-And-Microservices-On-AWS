module "user" {
  source = "../../lib/iam_user"
  name = "gaurav_user"
  policy_file = "policy.json"
}