
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

##variable "security_group_id" {
 ## description = "ID of the security group to attach to instances"
 ## type        = string
##}

variable "vpc_identifier" {
  description = "the id for the vpc. Checks if it is blue or green"
  type        = string
}
