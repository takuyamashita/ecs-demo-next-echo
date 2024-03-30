resource "aws_lb" "alb_front" {
  name_prefix                      = "front-"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb_front.id]
  subnets                          = [aws_subnet.alb_front_1a.id, aws_subnet.alb_front_1c.id]
  enable_deletion_protection       = false
  enable_http2                     = true
  enable_cross_zone_load_balancing = true
  idle_timeout                     = 60

  tags = {
    Name = "alb-front"
  }
}

resource "aws_lb_target_group" "next_1" {
  name_prefix = "next-"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    path                = "/"
    port                = 3000
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
    Name = "next"
  }

}

resource "aws_lb_target_group" "next_2" {
  name_prefix = "next-"
  port        = 3000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    path                = "/"
    port                = 3000
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
    Name = "next"
  }

}

resource "aws_lb_listener" "alb_next" {
  load_balancer_arn = aws_lb.alb_front.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.next_1.arn
  }
}
