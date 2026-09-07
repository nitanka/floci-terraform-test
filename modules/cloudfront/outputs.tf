output "cloudfront_distribution_domain_name" {
  description = "CloudFront distribution domain name"
  value       = module.cdn.cloudfront_distribution_domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = module.cdn.cloudfront_distribution_id
}
