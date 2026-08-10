variable "ap_south_1_vpc_id" {
  type = string
}

variable "ap_south_1_cidr_block" {
  type = string
}

variable "ap_south_1_public_route_table_ids" {
  type = list(string)
}

variable "ap_south_1_private_route_table_ids" {
  type = list(string)
}

variable "us_east_1_vpc_id" {
  type = string
}

variable "us_east_1_cidr_block" {
  type = string
}

variable "us_east_1_public_route_table_ids" {
  type = list(string)
}

variable "us_east_1_private_route_table_ids" {
  type = list(string)
}
