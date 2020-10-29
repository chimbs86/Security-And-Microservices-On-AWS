//resource "aws_api_gateway_rest_api" "ECommerceMarketingAPI" {
//  name        = "Campaign management API Test"
//  description = "Contains all methods related to campaign management"
//}
//
//resource "aws_api_gateway_resource" "GetCampaignIdResource" {
//  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
//  parent_id   = aws_api_gateway_rest_api.ECommerceMarketingAPI.root_resource_id
//  path_part   = "getCapmaignId"
//}
//
//resource "aws_api_gateway_method" "GetCampaignId" {
//  rest_api_id   = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
//  resource_id   = aws_api_gateway_resource.GetCampaignIdResource.id
//  http_method   = "GET"
//  authorization = "NONE"
//}
//
//
//resource "aws_api_gateway_integration" "MyDemoIntegration" {
//  rest_api_id          = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
//  resource_id          = aws_api_gateway_resource.GetCampaignIdResource.id
//  http_method          = aws_api_gateway_method.GetCampaignId.http_method
//  type                 = "MOCK"
//  timeout_milliseconds = 29000
//
//
//}

resource "aws_api_gateway_rest_api" "MyDemoAPI" {
  name        = "MyDemoAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "MyDemoResource" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id   = aws_api_gateway_rest_api.MyDemoAPI.root_resource_id
  path_part   = "mydemoresource"
}

resource "aws_api_gateway_method" "MyDemoMethod" {
  rest_api_id   = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id   = aws_api_gateway_resource.MyDemoResource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id          = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id          = aws_api_gateway_resource.MyDemoResource.id
  http_method          = aws_api_gateway_method.MyDemoMethod.http_method
  type                 = "MOCK"
  cache_key_parameters = ["method.request.path.param"]
  cache_namespace      = "foobar"
  timeout_milliseconds = 29000

  request_parameters = {
    "integration.request.header.X-Authorization" = "'static'"
  }

  # Transforms the incoming XML request to JSON
  request_templates = {
    "application/xml" = <<EOF
{
   "body" : $input.json('$')
}
EOF
  }
}