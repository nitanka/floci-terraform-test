resource "aws_iam_role" "replication" {
    count = var.enable_replication ? 1 : 0
    name  = "${var.bucket}-s3-replication"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action    = "sts:AssumeRole"
            Effect    = "Allow"
            Principal = { Service = "s3.amazonaws.com" }
        }]
    })
}

resource "aws_iam_role_policy" "replication" {
    count = var.enable_replication ? 1 : 0
    name  = "${var.bucket}-s3-replication"
    role  = aws_iam_role.replication[0].id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action   = ["s3:GetReplicationConfiguration", "s3:ListBucket"]
                Effect   = "Allow"
                Resource = [local.bucket_arn]
            },
            {
                Action = [
                    "s3:GetObjectVersionForReplication",
                    "s3:GetObjectVersionAcl",
                    "s3:GetObjectVersionTagging",
                ]
                Effect   = "Allow"
                Resource = ["${local.bucket_arn}/*"]
            },
            {
                Action = [
                    "s3:ReplicateObject",
                    "s3:ReplicateDelete",
                    "s3:ReplicateTags",
                ]
                Effect   = "Allow"
                Resource = ["${var.replica_bucket_arn}/*"]
            },
        ]
    })
}

module "s3" {

    #Initialising
    source          = "terraform-aws-modules/s3-bucket/aws"
    version         = "~> 5.14"

    #Basic Bucket
    create_bucket   = var.create_bucket
    bucket          = var.bucket
    bucket_prefix   = var.bucket_prefix
    region          = var.region
    tags            = local.tags

    #Logging & Versioning
    logging         = var.logging
    versioning      = var.versioning

    #Lifecycle Rule
    lifecycle_rule  = var.lifecycle_rule


    #Replication
    replication_configuration = local.replication_configuration

    #Encryption
    server_side_encryption_configuration = var.server_side_encryption_configuration

    #Policies
    attach_policy   = var.attach_policy
}