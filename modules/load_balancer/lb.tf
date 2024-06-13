resource "aws_lb" "my_load_balancer" {
  count = var.enable_lb ? 1 : 0
  name               = "my-load-balancer"
  load_balancer_type = "application"
  subnets         = var.my_subnet
  security_groups = var.my_sgs
}

resource "aws_lb_target_group" "target_group" {
  count = var.enable_lb ? 1 : 0
  name        = "my-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.my_vpc
  target_type = "instance"
}

resource "aws_lb_listener" "my_listener" {
  count = var.enable_lb ? 1 : 0
  load_balancer_arn = aws_lb.my_load_balancer[0].arn
  port              = "80"

  default_action {
    type = "forward"

    target_group_arn = aws_lb_target_group.target_group[0].arn
  }
}

# resource "aws_lb_target_group_attachment" "s3_attachment" {
#   target_group_arn = aws_lb_target_group.target_group.arn
#   target_id        = "${{}}.s3.amazonaws.com"
#   port             = 80
# }
