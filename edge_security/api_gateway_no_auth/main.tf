resource "aws_api_gateway_rest_api" "ECommerceMarketingAPI" {
  name = "Campaign management API Test2"
  description = "Contains all methoeds related to campaign management"
}

resource "aws_api_gateway_resource" "GetCampaignIdResource" {
  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  parent_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.root_resource_id
  path_part = "getCampaignId"
}

resource "aws_api_gateway_method" "GetCampaignId" {
  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  resource_id = aws_api_gateway_resource.GetCampaignIdResource.id
  http_method = "GET"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "GetCamoaignIntegration" {
  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  resource_id = aws_api_gateway_resource.GetCampaignIdResource.id
  http_method = aws_api_gateway_method.GetCampaignId.http_method
  type = "MOCK"
  timeout_milliseconds = 29000
  request_templates = {
    "application/json" = <<EOF
{
    "statusCode": 200
}
EOF
  }
  passthrough_behavior = "WHEN_NO_MATCH"
}
resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  resource_id = aws_api_gateway_resource.GetCampaignIdResource.id
  http_method = aws_api_gateway_method.GetCampaignId.http_method
  status_code = "200"

}

resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  resource_id = aws_api_gateway_resource.GetCampaignIdResource.id
  http_method = aws_api_gateway_method.GetCampaignId.http_method
  status_code = 200

  depends_on = [aws_api_gateway_method_response.response_200]

  # Transforms the backend JSON response to XML
  response_templates = {
    "application/json" = <<EOF
{
    "statusCode": 200
}
EOF
  }
}



