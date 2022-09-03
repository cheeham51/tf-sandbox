resource "aws_elasticache_cluster" "test-cluster" {
  cluster_id           = "test-cluster"
  engine               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis6.x"
  engine_version       = "6.2"
  port                 = 6379
  subnet_group_name    = "redis-vyfpbg"
  security_group_ids   = [aws_security_group.allow_redis.id]
}