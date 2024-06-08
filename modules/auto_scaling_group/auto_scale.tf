resource "aws_iam_instance_profile" "instance_profile" {
  count = var.enable_asg ? 1 : 0
  name  = "instance-profile"
  role = aws_iam_role.autoscale_role[0].name
}

resource "aws_iam_role" "autoscale_role" {
  count = var.enable_asg ? 1 : 0
  name  = "auto-scaling-group-role"
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
  name                      = "My auto-scaling group"
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  vpc_zone_identifier       = var.my_subnets
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  launch_configuration      = aws_launch_configuration.lc[0].name
}

resource "aws_launch_configuration" "lc" {
  count                = var.enable_asg ? 1 : 0
  name_prefix          = "example-lc"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = var.my_sgs
  iam_instance_profile = aws_iam_instance_profile.instance_profile[0].name
}


