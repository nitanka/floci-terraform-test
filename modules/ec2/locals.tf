locals {
    tags = merge(var.tags, {"managed-by" = "terraform", "owner" = "devops"})
}
