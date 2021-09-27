resource "aws_security_group" "worker_group_sg" {
  name_prefix = "worker_group_sg"
  vpc_id      = module.vpc.vpc_id
#  vpc_id      = "vpc-09b74fea1a9cd7253"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "10.1.0.0/16",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}