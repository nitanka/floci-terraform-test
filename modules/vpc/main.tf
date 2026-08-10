module "vpc" {
    
    #Initialisation
    source                                  = "terraform-aws-modules/vpc/aws"
    version                                 = "~> 6.6.1"
    
    #Basic VPC metadata
    name                                    = var.name
    tags                                    = local.common_tags
    

    #Network configuration
    cidr                                    = var.cidr
    azs                                     = local.azs

    #Subnetting
    private_subnets                         = var.private_subnets
    public_subnets                          = var.public_subnets

    #Gateway and Routing
    enable_nat_gateway                      = var.enable_nat_gateway
    create_igw                              = var.create_igw
    single_nat_gateway                      = var.single_nat_gateway
    default_security_group_ingress          = var.default_security_group_igress_rules

    #Network Audit Logs
    enable_flow_log                         = var.enable_flow_log
    create_flow_log_cloudwatch_iam_role     = var.create_flow_log_cloudwatch_iam_role
    create_flow_log_cloudwatch_log_group    = var.create_flow_log_cloudwatch_log_group
    flow_log_destination_type               = var.flow_log_destination_type
    flow_log_destination_arn                = var.flow_log_destination_arn
    flow_log_file_format                    = var.flow_log_file_format

    #Default Resource Management
    manage_default_security_group           = var.manage_default_security_group
    manage_default_network_acl              = var.manage_default_network_acl
    manage_default_route_table              = var.manage_default_route_table
}