resource "aws_iam_instance_profile" "instance_profile" {
  count = var.enable_asg ? 1 : 0
  name  = var.instance_profile_name
  role  = aws_iam_role.autoscale_role[0].name
}

resource "aws_iam_role" "autoscale_role" {
  count = var.enable_asg ? 1 : 0
  name  = var.asg_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_autoscaling_group" "autoscaling" {
  count                     = var.enable_asg ? 1 : 0
  name                      = var.asg_name
  desired_capacity          = var.asg_capacity
  max_size                  = var.asg_max_size
  min_size                  = var.asg_min_size
  vpc_zone_identifier       = var.my_subnets
  health_check_type         = var.asg_health_check_type
  health_check_grace_period = var.asg_health_check_grace_period
  force_delete              = var.asg_forse_delete
  launch_configuration      = aws_launch_configuration.my_lc[0].name
}

resource "aws_launch_configuration" "my_lc" {
  count                = var.enable_asg ? 1 : 0
  name                 = var.asg_lc_name
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = var.my_sgs
  iam_instance_profile = aws_iam_instance_profile.instance_profile[0].name
}


