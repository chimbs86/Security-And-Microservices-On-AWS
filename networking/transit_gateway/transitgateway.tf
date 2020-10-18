//resource "aws_ec2_transit_gateway" "example" {
//  description = "example"
//}
//
//resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
//  subnet_ids = [aws_subnet.production_customer.id]
//  transit_gateway_id = aws_ec2_transit_gateway.example.id
//  vpc_id             = aws_vpc.production.id
//}