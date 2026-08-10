name = "ap-south-1-vpc"

cidr = "10.0.0.0/16"

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
  "ap-south-1c",
]

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24",
  "10.0.3.0/24",
]

private_subnets = [
  "10.0.4.0/24",
  "10.0.5.0/24",
  "10.0.6.0/24",
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

bucket = "floci-ap-south-1-bucket"
region = "ap-south-1"

lifecycle_rule = [
  {
    id      = "glacier-transition"
    enabled = true

    transition = [
      {
        days          = 30
        storage_class = "GLACIER"
      }
    ]
  }
]

tags = {
  Environment = "dev"
  Region      = "ap-south-1"
  ManagedBy   = "terraform"
}
