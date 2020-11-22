resource "aws_route" "main_route" {
  vpc_peering_connection_id = var.peering_connection_id
  route_table_id = var.route_table_main_id
  destination_cidr_block = var.main_cidr_block
}


resource "aws_route" "customer_route" {
  destination_cidr_block = var.acceptor_cidr_block
  vpc_peering_connection_id = var.peering_connection_id
  route_table_id = var.route_table_acceptor_id
}