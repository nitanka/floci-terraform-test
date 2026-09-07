cdn_alias       = "html.floci.local"
cdn_bucket_name = "html"

cdn_origin_access_control = {
  name             = "html-oac"
  description      = "OAC for the html bucket origin"
  origin_type      = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

cdn_default_cache_behavior = {
  target_origin_id       = "s3-origin-0"
  viewer_protocol_policy = "redirect-to-https"
  allowed_methods        = ["GET", "HEAD"]
  cached_methods         = ["GET", "HEAD"]
}

tags = {
  Environment = "dev"
  Region      = "ap-south-1"
  ManagedBy   = "terraform"
}
