resource "aws_security_group" "allow_mysql" {
  name        = "allow_mysql"
  description = "Allow mysql inbound traffic"
  
  vpc_id      = "vpc-089da735be03bb32f"

  ingress {
    description = "Mysql from prod VPC"
    
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    
    # allow all traffic
    cidr_blocks = ["10.128.0.0/16"]
  }

  ingress {
    description = "Mysql from db VPC"
    
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    
    # allow all traffic
    cidr_blocks = ["192.168.0.0/22"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_mysql"
  }
}