locals {
    tags = merge(var.tags, {"managed-by" = "terraform", "owner" = "devops"})

    # Bucket ARN computed from the name rather than the module output, so the
    # replication IAM role/policy don't have to wait on the bucket being created.
    bucket_arn = "arn:aws:s3:::${var.bucket}"

    replication_configuration = var.enable_replication ? {
        role = aws_iam_role.replication[0].arn
        rules = [
            {
                id     = "bidirectional-replication"
                status = "Enabled"
                destination = {
                    bucket        = var.replica_bucket_arn
                    storage_class = "STANDARD"
                }
            }
        ]
    } : var.replication_configuration
}