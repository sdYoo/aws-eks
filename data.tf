data "aws_availability_zones" "available" {}

data "aws_ami" "amazon_linux2" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}

data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks.cluster_id
}