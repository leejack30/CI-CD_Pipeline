
resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
    subnets = [
    aws_subnet.subnet1.id,aws_subnet.subnet2.id]

  enable_deletion_protection = false


  tags = {
    Environment = "alb"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    enabled   = true
    path      = "/"
    port      = "traffic-port"
    interval  = 10
    protocol  = "HTTP"
    matcher   = "200"
  }
}


