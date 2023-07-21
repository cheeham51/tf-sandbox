# module "security_account_security_hub_syd" {
#   source           = "./modules/security-hub"
#   is_admin_account = true
#   admin_account_id = var.accounts_map.home
# }

# module "security_account_security_hub_use1" {
#   source = "./modules/security-hub"

#   providers = {
#     aws     = aws.sso
#   }
# }

# module "prod_account_security_hub_syd" {
#   source = "./modules/security-hub"

#   providers = {
#     aws     = aws.development
#   }
# }

# module "prod_account_security_hub_use1" {
#   source = "./modules/security-hub"

#   providers = {
#     aws     = aws.development-use1
#   }
# }

# resource "aws_securityhub_member" "org_member" {
#   account_id = "616625844834"
# }