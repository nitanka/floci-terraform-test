variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "cdn_name" {
  type    = string
  default = "floci-ap-south-1-cdn"
}

variable "cdn_alias" {
  type = string
}

variable "cdn_comment" {
  type    = string
  default = "floci ap-south-1 CDN"
}

variable "cdn_bucket_name" {
  description = "Name of the existing S3 bucket to serve as the CDN origin"
  type        = string
}

variable "cdn_default_cache_behavior" {
  type = any
}

variable "cdn_origin_access_control" {
  type = map(string)
}

variable "cdn_wait_for_deployment" {
  type    = bool
  default = false
}

variable "tags" {
  type    = map(string)
  default = {}
}
