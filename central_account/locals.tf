data "aws_availability_zones" "available" {
  
}

data "aws_caller_identity" "hub" {
  
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}

locals {
  dir_name            = basename(path.cwd)
  name                = "${var.project_name}-${var.environment}"

  hub_vpc_cidr        = "10.15.0.0/16"
  spoke_a_vpc_cidr    = "10.10.0.0/16"

  hub_azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  hub_az1             = data.aws_availability_zones.available.names[0]
  hub_az2             = data.aws_availability_zones.available.names[1]

  hub_ami             = data.aws_ami.amazon_linux_2.id

  common_tags = {
    Service = var.service_name
  }

}

