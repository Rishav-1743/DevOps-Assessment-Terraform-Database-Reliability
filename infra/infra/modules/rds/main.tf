resource "aws_db_instance" "database" {

  identifier = var.environment

  engine = "mysql"

  instance_class = var.instance_class

  allocated_storage = 20


  username = var.username

  password = var.password


  backup_retention_period = var.backup_retention


  deletion_protection = var.deletion_protection


  publicly_accessible = false


  skip_final_snapshot = var.skip_final_snapshot


  db_subnet_group_name = var.subnet_group_name


  vpc_security_group_ids = [
    var.security_group_id
  ]

}
