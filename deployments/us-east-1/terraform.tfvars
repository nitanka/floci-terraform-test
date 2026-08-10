name = "us-east-1-vpc"

cidr = "10.1.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
]

public_subnets = [
  "10.1.1.0/24",
  "10.1.2.0/24",
  "10.1.3.0/24",
]

private_subnets = [
  "10.1.4.0/24",
  "10.1.5.0/24",
  "10.1.6.0/24",
]

# LocalStack Community doesn't implement the EC2 DescribeAddressesAttribute call the AWS provider
# needs to read EIPs, so NAT gateways (which allocate an EIP) can't be applied locally
enable_nat_gateway = false
create_igw         = true
single_nat_gateway = true

# LocalStack Community doesn't emulate default SG/NACL/route table lookups reliably; disable for local testing only
manage_default_security_group = false
manage_default_network_acl    = false
manage_default_route_table    = false

bucket = "floci-us-east-1-bucket"
region = "us-east-1"

lifecycle_rule = [
  {
    id      = "glacier-transition"
    enabled = true

    transition = [
      {
        days          = 90
        storage_class = "GLACIER"
      }
    ]
  }
]

tags = {
  Environment = "dev"
  Region      = "us-east-1"
  ManagedBy   = "terraform"
}
