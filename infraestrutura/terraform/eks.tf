# Utilizar a LabRole existente do AWS Academy
data "aws_iam_role" "lab" {
  name = "LabRole"
}

# Cluster Kubernetes
resource "aws_eks_cluster" "main" {
  name     = "togglemaster-eks"
  role_arn = data.aws_iam_role.lab.arn
  version  = "1.35"

  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  vpc_config {
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]

    endpoint_public_access  = true
    endpoint_private_access = true
  }

  upgrade_policy {
    support_type = "STANDARD"
  }

  tags = {
    Name    = "togglemaster-eks"
    Project = "ToggleMaster"
  }
}
