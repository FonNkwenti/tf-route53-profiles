terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # version = "5.14.0"
    }
  }
}

provider "aws" {
  alias                     = "hub"
  region                    = var.hub_region
  shared_credentials_files  = ["~/.aws/credentials"]
  profile                   = "default"
  
  default_tags {
    tags = {
      UseCase               = "tutorial"
      Environment           = var.environment
      Project               = var.project_name
      ManagedBy             = "terraform"
      CostCenter            = var.cost_center
    }
  }
}
provider "aws" {
  alias                     = "spoke_a"
  region                    = var.spoke_a_region
  shared_credentials_files  = ["~/.aws/credentials"]
  profile                   = "aai-admin"
  
  default_tags {
    tags = {
      UseCase               = "tutorial"
      Environment           = var.environment
      Project               = var.project_name
      ManagedBy             = "terraform"
      CostCenter            = var.cost_center
    }
  }
}

