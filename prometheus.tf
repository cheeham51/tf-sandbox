# module "prometheus" {
#   source = "./modules/prometheus"
#   # providers = {
#   #   aws       = aws.env
#   #   aws.infra = aws
#   # }
#   env                 = terraform.workspace
#   route53_zone_id     = "Z0073171285WJGH31S21R"
#   vpc_private_subnets = ["subnet-18062671", "subnet-19062670", "subnet-1e441258"]
#   vpc_id              = "vpc-0606266f"

#   # source_bucket_name = data.terraform_remote_state.aws_infra_containers.outputs.deployment_artifacts_bucket_name
# }
