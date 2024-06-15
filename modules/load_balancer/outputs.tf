output "load_balancer_dns_name" {
  value = var.enable_lb ? aws_lb.my_load_balancer[0].dns_name : null
}
