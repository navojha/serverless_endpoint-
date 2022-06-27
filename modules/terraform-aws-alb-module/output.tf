
output "dns_name" {
  value = aws_lb.applications_load_balancer.dns_name
}

output "zone_id" {
  value = aws_lb.applications_load_balancer.zone_id
}


