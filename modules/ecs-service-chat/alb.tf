# ALB target group for ECS
resource "aws_lb_target_group" "main" {
  name        = var.name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/health"
    matcher             = "200-499"
    interval            = 300
    timeout             = 60
    unhealthy_threshold = 10
  }
}

resource "aws_lb_listener_rule" "main" {
  listener_arn = var.https_listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    host_header {
      values = ["${var.subdomain}.${var.domain}"]
    }
  }
}

resource "aws_lb_listener_certificate" "cert" {
  listener_arn    = var.https_listener_arn
  certificate_arn = var.acm_certificate_arn
}
