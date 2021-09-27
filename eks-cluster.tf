
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  
  cluster_name    = "rapa-k8s-cluster"
  cluster_version = "1.20"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
#  vpc_id          = "vpc-09b74fea1a9cd7253"
#  subnets         = ["subnet-0d0ec569cd2b0f53a", "subnet-0c877ea507377303a"]

  tags = {
    Environment = "test rapa eks"
  }
  
  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_max_size                  = 2
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.worker_group_sg.id]
    }
  ]
}

data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks.cluster_id
}