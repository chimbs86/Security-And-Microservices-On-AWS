resource "aws_api_gateway_deployment" "GetCampaignDeployment" {
  depends_on = [aws_api_gateway_integration.GetCamoaignIntegration]

  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  stage_name  = "test2"

  lifecycle {
    create_before_destroy = true
  }
}