create_vpc = true

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

tags = {
  Environment = "dev"
  Region      = "ap-south-1"
  ManagedBy   = "terraform"
}
