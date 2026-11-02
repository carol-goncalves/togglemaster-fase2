# Segurança dos bancos PostgreSQL
resource "aws_security_group" "rds" {
  name        = "togglemaster-rds-sg"
  description = "Security group for PostgreSQL databases"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "togglemaster-rds-sg"
    Project = "ToggleMaster"
  }
}

# Segurança do Redis
resource "aws_security_group" "redis" {
  name        = "togglemaster-redis-sg"
  description = "Security group for Redis"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name    = "togglemaster-redis-sg"
    Project = "ToggleMaster"
  }
}

# Permitir acesso do EKS ao PostgreSQL
resource "aws_vpc_security_group_ingress_rule" "rds_from_eks" {
  security_group_id = aws_security_group.rds.id

  referenced_security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id

  ip_protocol = "tcp"
  from_port   = 5432
  to_port     = 5432

  description = "Allow PostgreSQL access from EKS"
}

# Permitir acesso do EKS ao Redis
resource "aws_vpc_security_group_ingress_rule" "redis_from_eks" {
  security_group_id = aws_security_group.redis.id

  referenced_security_group_id = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id

  ip_protocol = "tcp"
  from_port   = 6379
  to_port     = 6379

  description = "Allow Redis access from EKS"
}
