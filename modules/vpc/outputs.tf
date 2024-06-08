output "vpc_id" {
  value = var.enable_vpc ? aws_vpc.my_vpc[0].id : null
}

output "public_subnet_id" {
  value = var.enable_vpc ? aws_subnet.public_subnet[0].id : null
}

output "private_subnet_id" {
  value = var.enable_vpc ? aws_subnet.private_subnet[0].id : null
}

output "security_group_id" {
  value = var.enable_vpc ? aws_security_group.my_sg[0].id : null
}
