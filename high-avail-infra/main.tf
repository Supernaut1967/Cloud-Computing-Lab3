# high-availability/main.tf

resource "aws_launch_template" "lab-3-template" {
  name_prefix   = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.launch_template_name}-instance"
    }
  }
}

resource "aws_autoscaling_group" "lab-3-asg" {
  name                    = "${var.launch_template_name}-asg"
  launch_template {
    id = aws_launch_template.lab-3-template.id
  }
  desired_capacity        = var.desired_capacity
  max_size                = var.max_size
  min_size                = var.min_size
  vpc_zone_identifier     = var.public_subnet_ids
}

resource "aws_alb" "lab-3-alb" {
  name               = var.alb_name
  internal           = var.alb_internal
  security_groups    = var.alb_security_group_ids
  subnets            = var.public_subnet_ids
}

resource "aws_alb_target_group" "lab-3-alb-tg" {
  name                 = var.target_group_name
  port                 = var.target_group_port
  protocol             = "HTTP"
  vpc_id                = var.vpc_id
  health_check {
    path                = var.alb_target_group_health_check_path
    interval            = var.alb_target_group_health_check_interval
    timeout             = var.alb_target_group_health_check_timeout
    healthy_threshold   = var.alb_target_group_health_check_healthy_threshold
    unhealthy_threshold = var.alb_target_group_health_check_unhealthy_threshold
  }
}

resource "aws_alb_listener" "lab-3-alb-list" {
  load_balancer_arn = aws_alb.lab-3-alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.lab-3-alb-tg.arn
  }
}
