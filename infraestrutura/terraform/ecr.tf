locals {
  services = toset([
    "auth",
    "flag",
    "targeting",
    "evaluation",
    "analytics"
  ])
}

resource "aws_ecr_repository" "services" {
  for_each = local.services

  name                 = "togglemaster-${each.key}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name    = "togglemaster-${each.key}"
    Project = "ToggleMaster"
  }
}
