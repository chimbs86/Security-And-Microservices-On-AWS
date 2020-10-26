resource "aws_api_gateway_rest_api" "ECommerceMarketingAPI" {
  name        = "MyDemoAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "GetCampaignIdResource" {
  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  parent_id   = aws_api_gateway_rest_api.ECommerceMarketingAPI.root_resource_id
  path_part   = "getCapmaignId"
}

resource "aws_api_gateway_method" "MyDemoMethod" {
  rest_api_id   = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  resource_id   = aws_api_gateway_resource.GetCampaignIdResource.id
  http_method   = "GET"
  authorization = "NONE"
}