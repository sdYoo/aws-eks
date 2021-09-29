provider "aws" {
  region = var.region
}

locals {
  cluster_name = "rapa-k8s-cluster"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  version = "3.2.0"

  name                 = var.vpc_name
  cidr                 = "10.0.0.0/16"
  azs                  = var.vpc_azs
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}