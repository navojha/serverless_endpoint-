###############################################################
## Application Load Balancer
###############################################################
variable "application_load_balancer_name" {
  description = "Name of the APplication Load Balancer"
  type        = string
  default     = "my-ALB"
}
variable "internal_or_internet_facing" {
  description = "Whether ALB should be internal or internet-facing-- True means internal & False means internet-facing"
  type        = bool
  default     = false
}

variable "alb_environment_tag" {
  description = "mention the environment name"
  type        = string
  default     = "test"
}
variable "loadBalancer_type" {
  description = "Mention the type of load balancer you need- 'application', 'network', 'gateway'"
  type        = string
  default     = "application"
}
variable "drop_invalid_header_alb" {
  description = "Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false)."
  type        = bool
  default     = false
}
variable "timeout_idle_alb" {
  description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application."
  type        = number
  default     = 60
}

variable "vpc_id" {
  type    = string
}

variable "security_group_id" {
  type    = list(any)
}

variable "public_subnet_ids" {
  type    = list(any)
}

variable alb_request_methods {
  description = "The request methods to be created on the ALB."
  type = list(string)
  default = ["GET"]
}

variable "path_pattern" {
  type    = list(any)
  default = ["/lambda/get-objects"]
}

variable "fixed_response_content_type" {
  type        = string
  default     = "text/plain"
}

variable "fixed_response_message_body" {
  type        = string
  default     = "Only HTTP GET method accepting via '/lambda/get-objects'"
}

variable "fixed_response_status_code" {
  type        = string
  default     = "200"
}

variable "default_action_type" {
  type        = string
  default     = "fixed-response"
}

variable "aws_lb_listener_port" {
  type        = number
  default     = 80
}

variable "aws_lb_listener_protocol" {
  type        = string
  default     = "HTTP"
}

variable "aws_lb_listener_rule_type" {
  type        = string
  default     = "forward"
}

variable "aws_lb_target_group_type" {
  type        = string
  default     = "lambda"
}

variable "aws_lb_target_group_name" {
  type        = string
  default     = "lambda-tg"
}

variable "aws_lb_target_group_tag" {
  type        = string
  default     = "lambda-tg"
}