variable "name" {
    description = "Name to use for the Cloudfront"
    type        = string
    default     = "local-cdn"
}

variable "alias" {
    description = "alias domain name"
    type        = string
}

variable "comment" {
    description = "comments for the cloudfront"
    type        = string
}

variable "default_cache_behavior" {
    description = "The default behavior of cache"
    type        = any
}

variable "cache_policy" {
    description = "Cache policy for the Cloudfront"
    type        = map(string)
    default     = {}
}

variable "create_cache_policy" {
    description = "Whether to create a cache policy in this module. If false, an existing policy ID must be passed via cache_policy[\"id\"]"
    type        = bool
    default     = true
}

variable "tags" {
    description = "Tags to be applied"
    type        = map(string)
    default     = {
      "type"                = "local"
      "maintenance-tier"    = "p3"
    }
}

variable "http_version" {
    description     = "The maximum http version"
    type            = string
    default         = "http2"
}

variable "is_ipv6_enabled" {
    description     = "To enable ipv6"
    type            = bool
    default         = false
}

variable "s3_bucket" {
    description     = "The source bucket for the cloudfront"
    type            = list(string)
}

variable "origin_access_control" {
    description     = "Access control for the origin"
    type            = map(string)
}

variable "wait_for_deployment" {
    description     = "f enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this to false will skip the process"
    type            = bool
}

variable "alb_origin_domain" {
    description     = "Domain name of the ALB/ingress origin (e.g. k8s ingress LB DNS name). Leave null to skip adding this origin"
    type            = string
    default         = null
}

variable "alb_path_pattern" {
    description     = "Path pattern routed to the ALB/ingress origin"
    type            = string
    default         = "/api/*"
}