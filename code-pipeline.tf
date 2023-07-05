module "test-code-pipeline" {
  source = "./modules/code-pipeline"
}

module "lambda-test-code-pipeline" {
  source = "./modules/lambda-code-pipeline"
}