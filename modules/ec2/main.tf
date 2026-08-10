data "aws_vpc" "selected" {
    count = var.create_ec2_instance ? 1 : 0
    id    = var.vpc_id
}

# Ephemeral keypair — generated on apply, never checked into git or written to disk.
# Private key material only ever lives in the (encrypted) Terraform state.
resource "tls_private_key" "ec2" {
    count     = var.create_ec2_instance ? 1 : 0
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "ec2" {
    count      = var.create_ec2_instance ? 1 : 0
    key_name   = var.name
    public_key = tls_private_key.ec2[0].public_key_openssh
}

module "ec2_instance" {

    #Initialising
    source  = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 6.0"

    count = var.create_ec2_instance ? 1 : 0

    #Basic instance
    name          = var.name
    instance_type = var.instance_type
    key_name      = aws_key_pair.ec2[0].key_name
    monitoring    = var.monitoring
    subnet_id     = var.subnet_id

    #Startup script
    user_data                   = var.user_data
    user_data_replace_on_change = var.user_data_replace_on_change

    tags = merge(local.tags, {
        VpcName = data.aws_vpc.selected[0].tags["Name"]
    })
}
