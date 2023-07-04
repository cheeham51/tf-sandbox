# module "aurora_db" {
#   source               = "./modules/aurora"
#   env                  = "test"
#   cluster_identifier   = "frankie-test"
#   database_name        = "test"
#   db_subnet_group_name = "portal"
#   master_username      = "test"
#   master_password      = "PASSWORD123"

#   vpc_id                = "vpc-089da735be03bb32f"
#   security_group_name   = "default"
#   multi_az              = false
#   instance_class        = "db.t3.large"
#   instance_count        = 1
# }