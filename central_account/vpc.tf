
module "hub_vpc" {
  providers = {
    aws = aws.hub
    }
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "hub-vpc"
  cidr = local.hub_vpc_cidr

  azs             = local.hub_azs
  private_subnets = [for k, v in local.hub_azs : cidrsubnet(local.hub_vpc_cidr, 8, k + 10)]

  enable_nat_gateway = false
  single_nat_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_security_group = false
  manage_default_network_acl    = false

  tags = merge(local.common_tags, {
    Name = "${local.name}-hub-vpc"
  })
}



# module "spoke_a_vpc" {
#   source                = "terraform-aws-modules/vpc/aws"
#   version               = "~> 5.0"

#   name                  = "client-vpc"
#   cidr                  = local.spoke_a_vpc_cidr

#   azs                   = local.hub_azs
#   private_subnets       = [for k, v in local.hub_azs : cidrsubnet(local.spoke_a_vpc_cidr, 8, k + 10)]

#   enable_nat_gateway    = false
#   single_nat_gateway    = false

#   enable_dns_hostnames  = true
#   enable_dns_support    = true

#   tags = merge(local.common_tags, {
#     Name = "${local.name}-client-vpc"
#   })
# }

# resource "aws_route" "hub_to_client" {
#   count                  = length(module.hub_vpc.private_route_table_ids)
#   route_table_id         = element(module.hub_vpc.private_route_table_ids, count.index)
#   destination_cidr_block = local.spoke_a_vpc_cidr
#   transit_gateway_id     = aws_ec2_transit_gateway.hub_tgw.id
# }

# resource "aws_route" "client_to_hub" {
#   count                  = length(module.spoke_a_vpc.private_route_table_ids)
#   route_table_id         = element(module.spoke_a_vpc.private_route_table_ids, count.index)
#   destination_cidr_block = local.hub_vpc_cidr
#   transit_gateway_id     = aws_ec2_transit_gateway.hub_tgw.id
# }


# resource "aws_ec2_instance_connect_endpoint" "client_instance" {
#   subnet_id           = element(module.spoke_a_vpc.private_subnets, 0)  
#   depends_on          = [module.client_instance]
#   security_group_ids  = [module.client_instance_connect_security_group.security_group_id]

#   tags                = merge(local.common_tags, {
#     Name              = "${local.name}-alb-sg"
#   })
# }
