resource "aws_route" "main_route" {
  cidr_block = var.main_cidr_block
  vpc_peering_connection_id = var.peering_connection_id
  route_table_id = var.route_table_main_id
}


resource "aws_route" "customer_route" {
  cidr_block = var.acceptor_cidr_block
  vpc_peering_connection_id = var.peering_connection_id
  route_table_id = var.route_table_acceptor_id
}