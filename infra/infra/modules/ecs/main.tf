resource "aws_ecs_cluster" "cluster" {

  name = "${var.environment}-cluster"

}


resource "aws_ecs_service" "service" {

  name = "${var.environment}-service"


  cluster = aws_ecs_cluster.cluster.id


  desired_count = var.desired_count


  launch_type = "FARGATE"


}
