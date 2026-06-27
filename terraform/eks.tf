module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~>20.0"

  cluster_name = var.cluster_name
  cluster_version = "1.34"
  vpc_id = aws_vpc.main.id
  subnet_ids = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  eks_managed_node_groups = {
    default = {
        instant_types = [var.node_instance_type]
        min_size = 2
        max_size = 2
        desired_size = 2
    }
  }
}