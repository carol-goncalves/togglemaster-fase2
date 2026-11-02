# Grupo de subnets privadas para o Redis
resource "aws_elasticache_subnet_group" "redis" {
  name = "togglemaster-redis-subnet-group"

  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

# Instância Redis
resource "aws_elasticache_cluster" "redis" {
  cluster_id = "togglemaster-redis"

  engine               = "redis"
  engine_version       = "7.1"
  node_type            = "cache.t4g.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis7"
  port                 = 6379

  subnet_group_name  = aws_elasticache_subnet_group.redis.name
  security_group_ids = [aws_security_group.redis.id]

  snapshot_retention_limit = 0

  tags = {
    Name    = "togglemaster-redis"
    Project = "ToggleMaster"
  }
}
