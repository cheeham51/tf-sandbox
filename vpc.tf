module "test_vpc" {
  source = "./modules/env-vpc"
  
  env                               = "test"
  vpc_cidr                          = var.cidr_map.home
  vpc_private_subnet_cidr           = var.home_private_subnet_cidr
  vpc_public_subnet_cidr            = var.home_public_subnet_cidr
  vpc_elasticache_subnet_cidr       = var.home_elasticache_subnet_cidr
  vpc_elasticache_subnet_group_name = var.home_vpc_elasticache_subnet_group_name

  db_vpc_cidr                       = var.home_db_vpc_cidr
  db_vpc_private_subnet_cidr        = var.home_db_vpc_private_subnet_cidr
  db_vpc_database_subnet_group_name = var.home_db_vpc_subnet_group_name
}
