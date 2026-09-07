resource "aws_cloudfront_cache_policy" "this" {
  count = var.create_cache_policy ? 1 : 0

  name        = var.name
  comment     = var.comment
  default_ttl = 86400
  max_ttl     = 31536000
  min_ttl     = 1

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config { cookie_behavior = "none" }
    headers_config { header_behavior = "none" }
    query_strings_config { query_string_behavior = "none" }
  }
}

module "cdn" {
    source                  = "terraform-aws-modules/cloudfront/aws"
    version                 = "6.7.1"
    aliases                 = [var.alias]
    comment                 = var.comment
    default_cache_behavior  = merge(var.default_cache_behavior, {
        cache_policy_id = var.create_cache_policy ? aws_cloudfront_cache_policy.this[0].id : var.cache_policy["id"]
    })
    tags                    = local.tags
    wait_for_deployment     = var.wait_for_deployment
    http_version            = var.http_version

    origin                  = local.origin
    origin_access_control   = {
        s3_oac = var.origin_access_control
    }
    ordered_cache_behavior  = local.ordered_cache_behavior
}