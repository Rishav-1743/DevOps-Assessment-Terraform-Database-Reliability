module "network" {

source = "../../modules/network"


environment = var.environment

vpc_cidr = "10.0.0.0/16"

}


module "ecs" {

source = "../../modules/ecs"


environment = var.environment


desired_count = var.ecs_instance_count

}



module "rds" {

source = "../../modules/rds"


environment = var.environment


instance_class = var.rds_instance_class


backup_retention = var.backup_retention


deletion_protection = var.deletion_protection


skip_final_snapshot = true


username = "admin"

password = "password123"


subnet_group_name = "dev-db-subnet"


security_group_id = "sg-xxxx"

}
