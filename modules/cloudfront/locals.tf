locals {
    tags = merge(var.tags, {"managed-by" = "terraform", "owner" = "devops"})

    s3_origin = {
        for idx, bucket in var.s3_bucket : "s3-origin-${idx}" => {
            domain_name              = bucket
            origin_access_control_id = "s3_oac"
        }
    }

    alb_origin = var.alb_origin_domain == null ? {} : {
        "alb-origin" = {
            domain_name = var.alb_origin_domain
            custom_origin_config = {
                http_port              = 80
                origin_protocol_policy = "http-only"
            }
        }
    }

    origin = merge(local.s3_origin, local.alb_origin)

    ordered_cache_behavior = var.alb_origin_domain == null ? [] : [
        {
            path_pattern           = var.alb_path_pattern
            target_origin_id       = "alb-origin"
            viewer_protocol_policy = "redirect-to-https"
            allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
            cached_methods         = ["GET", "HEAD"]
            cache_policy_id        = var.create_cache_policy ? aws_cloudfront_cache_policy.this[0].id : var.cache_policy["id"]
        }
    ]
}
