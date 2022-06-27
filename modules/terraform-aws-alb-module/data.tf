output "target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}

output "aws_lb_listener_arn" {
  value = aws_lb_listener.front_end.arn
}
