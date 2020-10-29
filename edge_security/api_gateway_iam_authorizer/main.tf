resource "aws_api_gateway_rest_api" "ECommerceMarketingAPI" {
  name        = "Campaign management API Test"
  description = "Contains all methoeds related to campaign management"
}

resource "aws_api_gateway_resource" "GetCampaignIdResource" {
  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  parent_id   = aws_api_gateway_rest_api.ECommerceMarketingAPI.root_resource_id
  path_part   = "getCapmaignId"
}

resource "aws_api_gateway_method" "GetCampaignId" {
  rest_api_id   = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  resource_id   = aws_api_gateway_resource.GetCampaignIdResource.id
  http_method   = "GET"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id          = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  resource_id          = aws_api_gateway_resource.GetCampaignIdResource.id
  http_method          = aws_api_gateway_method.GetCampaignId.http_method
  type                 = "MOCK"
  timeout_milliseconds = 29000
request_templates = {
  "application/json" = {"statusCode": 200}
}

}