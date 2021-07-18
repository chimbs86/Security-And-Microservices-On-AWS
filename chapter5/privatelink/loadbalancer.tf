
resource "aws_lb" "finance_service_loadbalancer" {
  name = "finance-service-loadbalancer"
  #can also be obtained from the variable nlb_config
  load_balancer_type = "network"
  internal = false

  subnet_mapping {
    subnet_id = module.vpc_structure.finance_subnet_id
  }
  tags = {
    Environment = "prod"
  }
}
resource "aws_lb_target_group" "ip-example" {
  name        = "financenlb"
  port        = 80
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = module.vpc_structure.finance_vpc_id
  connection {
    host = module.ec2_finance.private_ip
    port = 80
    type = "TCP"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.finance_service_loadbalancer.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ip-example.arn
  }
}
