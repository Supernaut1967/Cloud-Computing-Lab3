# main.tf

module "vpc_blue" {
  source             = "./vpc"
  vpc_identifier     = "blue"
  vpc_cidr_block     = "192.168.0.0/16"
  subnet_cidr_blocks = ["192.168.0.0/24", "192.168.16.0/24", "192.168.32.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  ##security_group_id  = module.security_group_blue.security-group-id-blue
}

module "vpc_green" {
  source             = "./vpc"
  vpc_identifier     = "green"
  vpc_cidr_block     = "100.64.0.0/16"
  subnet_cidr_blocks = ["100.64.0.0/24", "100.64.16.0/24", "100.64.32.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  ##security_group_id  = module.security_group_green.security-group-id-green
}


module "security_group_blue" {
  source = "./security-group"
  vpc_id = module.vpc_blue.vpc_id
}

module "security_group_green" {
  source = "./security-group"
  vpc_id = module.vpc_green.vpc_id
}

module "high_availability_infrastructure" {
  source = "./high-avail-infra"

  launch_template_name                              = "Lab-3-template-blue"
  ami_id                                            = "ami-0c101f26f147fa7fd"
  instance_type                                     = "t2.micro"
  desired_capacity                                  = 3
  max_size                                          = 3
  min_size                                          = 2
  public_subnet_ids                                 = module.vpc_blue.public_subnet_ids
  alb_name                                          = "Lab-3-alb"
  alb_internal                                      = false
  target_group_name                                 = "Lab-3-target-group"
  target_group_port                                 = 80
  listener_port                                     = 80
  listener_protocol                                 = "HTTP"
  alb_security_group_ids                            = [module.security_group_blue.security-group-id-blue]
  alb_target_group_health_check_path                = "/"
  alb_target_group_health_check_interval            = 30
  alb_target_group_health_check_timeout             = 10
  alb_target_group_health_check_healthy_threshold   = 3
  alb_target_group_health_check_unhealthy_threshold = 2
  vpc_id                                            = module.vpc_blue.vpc_id



}

module "high_availability_infrastructure_green" {
  source = "./high-avail-infra"

  launch_template_name                              = "Lab-3-template-green"
  ami_id                                            = "ami-0c101f26f147fa7fd"
  instance_type                                     = "t2.micro"
  desired_capacity                                  = 3
  max_size                                          = 3
  min_size                                          = 2
  public_subnet_ids                                 = module.vpc_green.public_subnet_ids
  alb_name                                          = "Lab-3-alb-green"
  alb_internal                                      = false
  target_group_name                                 = "Lab-3-target-group-green"
  target_group_port                                 = 80
  listener_port                                     = 80
  listener_protocol                                 = "HTTP"
  alb_security_group_ids                            = [module.security_group_green.security-group-id-green]
  alb_target_group_health_check_path                = "/"
  alb_target_group_health_check_interval            = 30
  alb_target_group_health_check_timeout             = 10
  alb_target_group_health_check_healthy_threshold   = 3
  alb_target_group_health_check_unhealthy_threshold = 2
  vpc_id                                            = module.vpc_green.vpc_id
}

output "vpc_blue_public_subnet_ids" {
  value = module.vpc_blue.public_subnet_ids
}

output "vpc_green_public_subnet_ids" {
  value = module.vpc_green.public_subnet_ids
}

output "vpc_blue_id" {
  value = module.vpc_blue.vpc_id
}

output "vpc_green_id" {
  value = module.vpc_green.vpc_id
}
