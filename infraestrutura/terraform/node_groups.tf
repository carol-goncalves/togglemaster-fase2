# Utilizar a função existente do AWS Academy
data "aws_iam_role" "eks_nodes" {
  name = "c230647a5803677l17900967t1w698126163-LabEksNodeRole-V414xfWKTJMJ"
}

# Servidores Kubernetes
resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "togglemaster-nodes"
  node_role_arn   = data.aws_iam_role.eks_nodes.arn

  subnet_ids = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  ami_type       = "BOTTLEROCKET_x86_64"
  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name    = "togglemaster-nodes"
    Project = "ToggleMaster"
  }
}
