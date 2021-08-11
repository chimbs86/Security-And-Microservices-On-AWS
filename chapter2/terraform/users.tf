# Simple user with a very simple policy. To view the actual user creation, please visit the folder specified in the source
module "simple_user" {
  source = "../../lib/iam_user"
  name = "gaurav_user"

  policy_json = file("policy.json")
}

module "user_with_principal_tag" {
  source = "../../lib/iam_user"
  name = "sruthi"

  policy_json = file("access_with_principal_tag.json")
}


module "user_with_resource_tag" {
  source = "../../lib/iam_user"
  name = "andrew"

  policy_json = file("access_with_resource_tag.json")
}


