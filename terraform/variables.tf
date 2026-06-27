variable "aws_region" {
  type = string
  default = "us-east-1"
}

variable "cluster_name" {
  default = "angular-eks"
}

variable "node_instance_type" {
  default = "t3.medium"
}