module "api_gateway" {
    source = "./modules/api-gateway"
    env = terraform.workspace
}