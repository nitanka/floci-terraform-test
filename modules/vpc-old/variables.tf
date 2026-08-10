variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cidr" {
    description = "CIDR value of the VPC"
    type        = string
    default = "10.0.0.0/16" 
}

variable "availability_zones" {
  description = "List of availability zones to assign to subnets (must match length of public_subnets)"
  type        = list(string)
  default     = []
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default     = {}
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Condition for creating NAT gateway"
  type        = bool
  default     = false
}

variable "aws_eip_tags" {
  description = "Tags for the Elastic IP to be attached with the NAT"
}

variable "aws_nat_gateway_tags" {
  description = "Tags for the Nat Gateway to be attached with the NAT"
  default = {}
}

variable "single-nat" {
  description = "Single NAT gateway for the VPC"
  type        = bool
  default     = true
}

variable "per-subnet-nat" {
  description = "NAT gateway/Subnet in the VPC"
  type        = bool
  default     = false
}

variable "per-az-nat" {
  description = "NAT gateway/AZ in the VPC"
  type        = bool
  default     = false
}