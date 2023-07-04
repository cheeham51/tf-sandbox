locals {
  app_name = "ecs-fargate-otel"
}

resource "aws_security_group" "ecs_service_sg" {
  name = "${local.app_name}-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.0.0/16"]
  }
}

resource "aws_ecs_cluster" "this" {
  name = local.app_name
}

resource "aws_ecs_task_definition" "this" {
  family                   = local.app_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn

  container_definitions = jsonencode([
    {
      name  = "aws-otel-collector"
      image = "amazon/aws-otel-collector"
      essential = true
      command = ["--config=/etc/ecs/ecs-amp.yaml"]
      environment = [
        {
          name  = "AWS_REGION"
          value = "ap-southeast-2"
        },
        {
          name  = "AWS_PROMETHEUS_ENDPOINT"
          value = "https://aps-workspaces.ap-southeast-2.amazonaws.com/workspaces/ws-00815ccf-250c-4062-ac6b-9ec12a9b58f5/api/v1/remote_write"
        }
      ]
      logConfiguration = {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.example.name}",
          "awslogs-region": "ap-southeast-2",
          "awslogs-stream-prefix": "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = local.app_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = ["subnet-1e441258", "subnet-18062671", "subnet-19062670"]
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = true
  }
}

resource "aws_cloudwatch_log_group" "example" {
  name = "/ecs/my_log_group_test"
}

resource "aws_iam_role" "execution_role" {
  name = "ecsTaskExecutionRole-new"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.execution_role.name
}

resource "aws_iam_role" "task_role" {
  name = "task_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecsTaskRole_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.task_role.name
}
