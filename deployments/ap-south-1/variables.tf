### VPC ###

variable "name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "availability_zones" {
  type    = list(string)
  default = []
}

variable "public_subnets" {
  type    = list(string)
  default = []
}

variable "private_subnets" {
  type    = list(string)
  default = []
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "create_igw" {
  type    = bool
  default = true
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "default_security_group_igress_rules" {
  type    = list(map(string))
  default = []
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

### S3 ###

variable "create_bucket" {
  type    = bool
  default = true
}

variable "bucket" {
  type    = string
  default = null
}

variable "bucket_prefix" {
  type    = string
  default = null
}

variable "region" {
  type    = string
  default = null
}

variable "logging" {
  type    = any
  default = {}
}

variable "versioning" {
  type    = any
  default = {}
}

variable "lifecycle_rule" {
  type    = any
  default = []
}

variable "replication_configuration" {
  type    = any
  default = {}
}

variable "enable_replication" {
  type    = bool
  default = false
}

variable "replica_bucket_arn" {
  description = "ARN of the peer region's bucket to replicate into"
  type        = string
  default     = null
}

variable "server_side_encryption_configuration" {
  type    = any
  default = {}
}

variable "attach_policy" {
  type    = bool
  default = false
}

### EC2 ###

variable "create_ec2_instance" {
  type    = bool
  default = false
}

variable "instance_name" {
  type    = string
  default = "single-instance"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "instance_monitoring" {
  type    = bool
  default = true
}

variable "instance_subnet_type" {
  description = "Which module.vpc subnet list to place the instance in: public or private"
  type        = string
  default     = "public"
}

### Shared ###

variable "tags" {
  type    = map(string)
  default = {}
}
