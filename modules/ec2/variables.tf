variable "create_ec2_instance" {
    description = "Controls if the EC2 instance should be created"
    type        = bool
    default     = false
}

variable "name" {
    description = "Name to use for the EC2 instance"
    type        = string
    default     = "single-instance"
}

variable "instance_type" {
    description = "The type of instance to start"
    type        = string
    default     = "t3.micro"
}

variable "monitoring" {
    description = "If true, the launched EC2 instance will have detailed monitoring enabled"
    type        = bool
    default     = true
}

variable "subnet_id" {
    description = "The subnet ID to launch the instance in"
    type        = string
    default     = null
}

variable "vpc_id" {
    description = "The VPC ID the instance's subnet belongs to, used to look up the VPC's Name tag"
    type        = string
    default     = null
}

variable "tags" {
    description = "The tags to apply to the instance"
    type        = map(string)
    default     = {}
}

variable "user_data" {
    description = "The startup script (cloud-init/bash) to run on first boot"
    type        = string
    default     = null
}

variable "user_data_replace_on_change" {
    description = "If true, changing user_data forces instance replacement instead of a no-op"
    type        = bool
    default     = false
}
