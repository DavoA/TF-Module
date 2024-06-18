resource "aws_lb" "my_load_balancer" {
  count              = var.enable_lb ? 1 : 0
  name               = var.lb_name
  load_balancer_type = var.load_balancer_type
  subnets            = var.my_subnet
  security_groups    = var.my_sgs
}

resource "aws_lb_target_group" "target_group" {
  count       = var.enable_lb ? 1 : 0
  name        = var.lb_target_group_name
  port        = var.lb_target_group_port
  protocol    = var.lb_target_group_protocol
  vpc_id      = var.my_vpc
  target_type = var.lb_target_group_target_type
}

resource "aws_lb_listener" "my_listener" {
  count             = var.enable_lb ? 1 : 0
  load_balancer_arn = aws_lb.my_load_balancer[0].arn
  port              = var.lb_listener_port
  default_action {
    type             = var.listener_default_action_type
    target_group_arn = aws_lb_target_group.target_group[0].arn
  }
}

resource "aws_lb_target_group_attachment" "ec2_attachment" {
  count            = var.enable_lb && var.enable_ec2_attachment ? 1 : 0
  target_group_arn = aws_lb_target_group.target_group[0].arn
  target_id        = var.enable_ec2_attachment ? var.ec2_instance_id : null
  port             = var.attachment_port
}
