resource "aws_api_gateway_deployment" "GetCampaignDeployment" {
  depends_on = [aws_api_gateway_integration.GetCamoaignIntegration, aws_api_gateway_method_response.response_200]

  rest_api_id = aws_api_gateway_rest_api.ECommerceMarketingAPI.id
  stage_name  = "test2"


  lifecycle {
    create_before_destroy = true
  }
}