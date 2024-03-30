resource "aws_lb" "alb_echo" {
  name_prefix                      = "echo-"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb_echo.id]
  subnets                          = [aws_subnet.alb_echo_1a.id, aws_subnet.alb_echo_1c.id]
  enable_deletion_protection       = false
  enable_http2                     = true
  enable_cross_zone_load_balancing = true
  idle_timeout                     = 60

  tags = {
    Name = "alb-echo"
  }
}

resource "aws_lb_target_group" "echo_1" {
  name_prefix = "echo-"
  port        = 1323
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    path                = "/"
    port                = 1323
    protocol            = "HTTP"
    timeout             = 5
    interval            = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "echo"
  }

}

resource "aws_lb_target_group" "echo_2" {
  name_prefix = "echo-"
  port        = 1323
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    path                = "/"
    port                = 1323
    protocol            = "HTTP"
    timeout             = 5
    interval            = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "echo"
  }

}

resource "aws_lb_listener" "alb_echo" {
  load_balancer_arn = aws_lb.alb_echo.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.echo_1.arn
  }
}
