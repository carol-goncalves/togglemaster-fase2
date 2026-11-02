resource "aws_db_subnet_group" "main" {
  name        = "togglemaster-db-subnet-group"
  description = "Private subnets for ToggleMaster databases"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name    = "togglemaster-db-subnet-group"
    Project = "ToggleMaster"
  }
}
