module "ssm-documents" {
  source = "./modules/ssm"
}

module "ssm-documents-replication-lambda" {
  source = "./modules/ssm-params-replication-lambda"
}