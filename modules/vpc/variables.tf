variable "cidr" {
    description = "The cidr of the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "name" {
    type = string
    description = "The name of the vpc tag"
}

variable "tags" {
    type = map(string)
    description = "The tags to be used"
}

variable "availability_zones" {
    type = list(string)
    default = []
}

variable "public_subnets" {
    type = list(string)
    default = []
}

variable "private_subnets" {
    type = list(string)
    default = []
}

variable "enable_nat_gateway" {
    type    = bool
    default = true
}

variable "single_nat" {
    type    = bool
    default = true
}

variable "per_az_nat" {
    type    = bool
    default = false
}

variable "per_subnet_nat" {
    type    = bool
    default = false
}

variable "enable_vpn_gateway" {
    type = bool
    default = false
}

variable "single_nat_gateway" {
    type = bool
    default = true
}

variable "default_security_group_igress_rules" {
    type = list(map(string))
    default = []
}


variable "create_igw" {
    type    = bool
    default = true
}

variable "enable_flow_log" {
    type    = bool
    default = false
}

variable "create_flow_log_cloudwatch_iam_role" {
    type    = bool
    default = false
}

variable "create_flow_log_cloudwatch_log_group" {
    type    = bool
    default = false
}

variable "flow_log_cloudwatch_iam_role_arn" {
    type    = string
    default = null
}

variable "flow_log_destination_type" {
    type    = string
    default = "cloud-watch-logs"
}

variable "flow_log_destination_arn" {
    type    = string
    default = null
}

variable "flow_log_file_format" {
    type    = string
    default = "plain-text"
}

variable "manage_default_security_group" {
    type    = bool
    default = true
}

variable "manage_default_network_acl" {
    type    = bool
    default = true
}

variable "manage_default_route_table" {
    type    = bool
    default = true
}



