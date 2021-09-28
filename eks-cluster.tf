
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

  node_groups = {

    frontend = {
        name             = "frontend"
        desired_capacity = 1
        max_capacity     = 15
        min_capacity     = 1
        subnets = module.vpc.public_subnets
        instance_type = var.frontend_node_instance_type

        launch_template_id      = aws_launch_template.frontend.id
        launch_template_version = aws_launch_template.frontend.default_version

        additional_tags = {
          CustomTag = "frontend node group"
        }
    }
      
    backend = {
      name             = "backend"
      desired_capacity = 1
      max_capacity     = 15
      min_capacity     = 1
      subnets = module.vpc.public_subnets
      instance_type = var.backend_node_instance_type

      launch_template_id      = aws_launch_template.backend.id
      launch_template_version = aws_launch_template.backend.default_version

      additional_tags = {
        CustomTag = "backend node group"
      }
    }
  }
}

data "aws_eks_cluster" "eks_cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks_cluster" {
  name = module.eks.cluster_id
}