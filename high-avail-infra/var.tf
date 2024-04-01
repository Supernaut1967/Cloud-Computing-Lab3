# high-availability/variables.tf

variable "launch_template_name" {
  description = "launch template name"
  default     = "lab-3-temp"
}

variable "ami_id" {
  description = "ami id used in the launch template"
}

variable "instance_type" {
  description = "instance type used in the launch template"
}

variable "desired_capacity" {
  description = "the desired capacity in the auto scale group"
}

variable "max_size" {
  description = "the max size set in the auto scale group"
}

variable "min_size" {
  description = "the min size set in the auto scale group"
}

variable "public_subnet_ids" {
  description = "List of subnet IDs for the auto scaling group"
  type        = list(string)
}

variable "alb_name" {
  description = "the name of the application load balancer"
}

variable "alb_internal" {
  description = "Boolean flag indicating if the ALB is internal (true) or internet-facing (false)"
}

variable "target_group_name" {
  description = "the name of the target group"
}

variable "target_group_port" {
  description = "the port on which targets receive traffic from the load balancer"
}

variable "listener_port" {
  description = "the port on which the load balancer listens for incoming traffic"
}

variable "listener_protocol" {
  description = "the protocol for the listener"
}

variable "alb_security_group_ids" {
  description = "List of security group IDs for the application load balancer"
  type        = list(string)
}

variable "alb_target_group_health_check_path" {
  description = "the health check path for the ALB target group"
}

variable "alb_target_group_health_check_interval" {
  description = "the health check interval for the ALB target group"
}

variable "alb_target_group_health_check_timeout" {
  description = "the health check timeout for the ALB target group"
}

variable "alb_target_group_health_check_healthy_threshold" {
  description = "the healthy threshold for the ALB target group health check"
}

variable "alb_target_group_health_check_unhealthy_threshold" {
  description = "the Unhealthy threshold for the ALB target group health check"
}

variable "vpc_id" {}
