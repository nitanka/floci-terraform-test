variable "create_bucket" {
    description = "Controls if S3 bucket should be created"
    type        = bool
    default     = true
}

variable "bucket" {
    description = "The name of the bucket"
    type        = string
    default     = null
}

variable "bucket_prefix" {
    description = "Creates a unique bucket name beginning with the specified prefix"
    type        = string
    default     = null
}

variable "region" {
    description = "The AWS region this bucket should reside in"
    type        = string
    default     = null
}

variable "tags" {
    description = "The tags to apply to the bucket"
    type        = map(string)
    default     = {}
}

variable "logging" {
    description = "Map containing access bucket logging configuration"
    type        = any
    default     = {}
}

variable "versioning" {
    description = "Map containing versioning configuration"
    type        = any
    default     = {}
}

variable "lifecycle_rule" {
    description = "List of maps containing lifecycle rule configuration"
    type        = any
    default     = []
}

variable "replication_configuration" {
    description = "Map containing cross-region replication configuration. Ignored if enable_replication is true — set replica_bucket_arn instead."
    type        = any
    default     = {}
}

variable "enable_replication" {
    description = "If true, builds the replication IAM role/policy and a replication_configuration replicating every object to replica_bucket_arn"
    type        = bool
    default     = false
}

variable "replica_bucket_arn" {
    description = "ARN of the destination bucket to replicate into (the peer region's bucket). Required if enable_replication is true."
    type        = string
    default     = null
}

variable "server_side_encryption_configuration" {
    description = "Map containing server-side encryption configuration"
    type        = any
    default     = {}
}

variable "attach_policy" {
    description = "Controls if S3 bucket should have bucket policy attached (set to true if using policy var)"
    type        = bool
    default     = false
}
