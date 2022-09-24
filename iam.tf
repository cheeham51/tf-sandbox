module "iam" {
  source = "./modules/iam"
  providers = {
    aws.development = aws.development
  }
}
