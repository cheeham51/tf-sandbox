resource "aws_route" "private_subnet_db_vpc" {
  count                     = length(module.vpc.private_route_table_ids)
  route_table_id            = module.vpc.private_route_table_ids[count.index]
  destination_cidr_block    = module.db_vpc[0].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.db_vpc_peer.id
}

resource "aws_route" "public_subnet_db_vpc" {
  count                     = length(module.vpc.public_route_table_ids)
  route_table_id            = module.vpc.public_route_table_ids[count.index]
  destination_cidr_block    = module.db_vpc[0].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.db_vpc_peer.id
}

# DB Routes
resource "aws_route" "db_private_subnet_vpc" {
  count                     = var.provision_db_vpc ? length(module.db_vpc[0].database_route_table_ids) : 0
  route_table_id            = module.db_vpc[0].database_route_table_ids[count.index]
  destination_cidr_block    = module.vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.db_vpc_peer.id
}

# resource "aws_route" "database_route_vpc" {
#   count                     = var.provision_db_vpc ? length(module.db_vpc[0].database_route_table_ids) : 0
#   route_table_id            = module.db_vpc[0].database_route_table_ids[count.index]
#   destination_cidr_block    = module.vpc.vpc_cidr_block
#   vpc_peering_connection_id = aws_vpc_peering_connection.db_vpc_peer.id
# }