create_vpc = true

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

tags = {
  Environment = "dev"
  Region      = "us-east-1"
  ManagedBy   = "terraform"
}
