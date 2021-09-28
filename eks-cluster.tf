
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  
  cluster_name    = "rapa-k8s-cluster"
  cluster_version = "1.20"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
#  vpc_id          = "vpc-09b74fea1a9cd7253"
#  subnets         = ["subnet-0d0ec569cd2b0f53a", "subnet-0c877ea507377303a"]

  tags = {
    Environment = "test eks"
  }
  
  # Managed Node Groups
  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {

    frontend = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1

      instance_types = var.backend_node_instance_type

      #launch_template_id      = aws_launch_template.backend.id
      #launch_template_version = aws_launch_template.backend.default_version

      k8s_labels = {
        Environment = "test"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }

      additional_tags = {
        CustomTag = "backend node group"
      }

      taints = [
        {
          key    = "dedicated"
          value  = "gpuGroup"
          effect = "NO_SCHEDULE"
        }
      ]

      update_config = {
        max_unavailable_percentage = 50 # or set `max_unavailable`
      }
    }
  }
}