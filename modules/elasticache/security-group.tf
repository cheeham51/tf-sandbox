resource "aws_security_group" "allow_redis" {
  name        = "allow_redis"
  description = "Allow redis inbound traffic"
  
  # using default VPC
  vpc_id      = "vpc-0ac53f40fb31ec626"

  ingress {
    description = "redis"
    
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    
    # allow all traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_redis"
  }
}