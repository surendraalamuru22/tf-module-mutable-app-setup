resource "aws_launch_template" "launch-template" {
  name          = "${var.env}-${var.name}-lt"
  image_id      = "ami-0f3c7d07486cad139"
  instance_type = var.instance_type
}

resource "aws_autoscaling_group" "asg" {
  name                = "${var.env}-${var.name}-asg"
  desired_capacity    = var.min_size
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnets
#  target_group_arns   = [aws_lb_target_group.main.arn]

  launch_template {
    id      = aws_launch_template.launch-template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.env}-${var.name}"
    propagate_at_launch = true
  }
}