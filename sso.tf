module "sso" {
  source = "./modules/sso"
  providers = {
    aws = aws.sso
  }
}