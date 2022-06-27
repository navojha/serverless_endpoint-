######################################################
## Instance Target Group
######################################################

resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.aws_lb_target_group_name}"
  target_type = "${var.aws_lb_target_group_type}"
  tags = {
    "Name" = "${var.aws_lb_target_group_tag}"
  }
}
