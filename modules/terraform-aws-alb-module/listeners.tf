#############################################################
## Redirect Action
#############################################################
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.applications_load_balancer.arn}"
  port              = "${var.aws_lb_listener_port}"
  protocol          = "${var.aws_lb_listener_protocol}"

  default_action {
    type = "${var.default_action_type}"

    fixed_response {
      content_type = "${var.fixed_response_content_type}"
      message_body = "${var.fixed_response_message_body}"
      status_code  = "${var.fixed_response_status_code}"
    }
  }
}


resource aws_lb_listener_rule "alb_listener_rule" {
  listener_arn = "${aws_lb_listener.front_end.arn}"
  action {
    type = "${var.aws_lb_listener_rule_type}"
    target_group_arn = "${aws_lb_target_group.alb_target_group.arn}"
  }
  condition {
    path_pattern {
      values = "${var.path_pattern}"
    }
  }
  condition {
    http_request_method {
      values = "${var.alb_request_methods}"
    }
  }
}