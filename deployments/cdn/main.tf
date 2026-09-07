module "cloudfront" {
  source = "../../modules/cloudfront"

  name    = var.cdn_name
  alias   = var.cdn_alias
  comment = var.cdn_comment

  s3_bucket              = ["${var.cdn_bucket_name}.s3.${var.region}.amazonaws.com"]
  origin_access_control  = var.cdn_origin_access_control
  default_cache_behavior = var.cdn_default_cache_behavior

  wait_for_deployment = var.cdn_wait_for_deployment
  tags                = var.tags
}
