resource "aws_ecs_cluster" "cluster" {

  name = "demo-cluster"
}

resource "aws_ecs_task_definition" "task" {

  family = "nginx"

  network_mode = "awsvpc"

  requires_compatibilities = ["FARGATE"]

  cpu = "256"

  memory = "512"

  execution_role_arn = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name  = "nginx"

      image = "nginx:latest"

      essential = true

      portMappings = [
        {
          containerPort = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service" {

  name = "nginx-service"

  cluster = aws_ecs_cluster.cluster.id

  task_definition = aws_ecs_task_definition.task.arn

  desired_count = 2

  launch_type = "FARGATE"

  network_configuration {

    subnets = [
      aws_subnet.private1.id,
      aws_subnet.private2.id
    ]

    security_groups = [
      aws_security_group.ecs.id
    ]

    assign_public_ip = false
  }

  load_balancer {

    target_group_arn = aws_lb_target_group.ecs.arn

    container_name = "nginx"

    container_port = 80
  }
}
