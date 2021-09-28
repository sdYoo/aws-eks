variable "region" {
  default     = "ap-northeast-2"
  description = "AWS region"
}

variable "vpc_name" {
    type        = string
    default     = "rapa-eks-vpc"
    description = "vpc name"
}

variable "key_pair_name" {
    type        = string
    default     = "rapa-yoo-keypair"
    description = "keypair name"
}

variable "frontend_node_instance_type" {
  # Smallest recommended, where ~1.1Gb of 2Gb memory is available for the Kubernetes pods after ‘warming up’ Docker, Kubelet, and OS
  default = "m5.large"
  type    = string
}


variable "backend_node_instance_type" {
  # Smallest recommended, where ~1.1Gb of 2Gb memory is available for the Kubernetes pods after ‘warming up’ Docker, Kubelet, and OS
  default = "m5.large"
  type    = string
}