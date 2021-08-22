resource "aws_lb_listener" "https_redirect" {
  load_balancer_arn = aws_elastic_beanstalk_environment.default.load_balancers[0]
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
