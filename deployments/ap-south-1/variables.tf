variable "create_vpc" {
  type    = bool
  default = true
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

variable "public_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "public_route_table_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnets" {
  type    = list(string)
  default = []
}

variable "private_subnet_tags" {
  type    = map(string)
  default = {}
}

variable "private_route_table_tags" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
