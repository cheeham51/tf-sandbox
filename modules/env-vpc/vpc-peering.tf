resource "aws_vpc_peering_connection" "db_vpc_peer" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = "vpc-0ac53f40fb31ec626"
  vpc_id        = "vpc-089da735be03bb32f"
  auto_accept   = true

  tags = {
    Name = "db_to_vpc"
  }
}
