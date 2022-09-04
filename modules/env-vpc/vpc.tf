module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = "${var.env}-vpc"
  cidr = var.vpc_cidr

  azs                 = var.vpc_az
  private_subnets     = var.vpc_private_subnet_cidr
  public_subnets      = var.vpc_public_subnet_cidr
  elasticache_subnets = var.vpc_elasticache_subnet_cidr

  elasticache_subnet_group_name = var.vpc_elasticache_subnet_group_name

  create_elasticache_subnet_route_table = false
  
  enable_dns_hostnames = true
  enable_nat_gateway   = false
  enable_vpn_gateway   = false

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}

module "db_vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  count = var.provision_db_vpc ? 1 : 0

  name = "${var.env}-db-vpc"
  cidr = var.db_vpc_cidr

  azs                        = var.vpc_az
  database_subnets           = var.db_vpc_private_subnet_cidr
  database_subnet_group_name = var.db_vpc_database_subnet_group_name

  create_database_subnet_route_table = false

  enable_dns_hostnames = true
  enable_nat_gateway   = false
  enable_vpn_gateway   = false

  tags = {
    Terraform   = "true"
    Environment = var.env
  }
}
