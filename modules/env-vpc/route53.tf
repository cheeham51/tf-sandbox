resource "aws_route53_zone" "env" {
  count = length(var.env_domains)
  name  = var.env_domains[count.index]
}

# resource "aws_cloudwatch_log_group" "aws_route53_frankie_log_group" {
#   provider = aws.sso
#   count             = length(var.env_domains)
#   name              = "/aws/route53/${var.env_domains[count.index]}"
#   retention_in_days = 30
# }

# data "aws_iam_policy_document" "route53-query-logging-policy" {
#   statement {
#     actions = [
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#     ]

#     resources = ["arn:aws:logs:*:*:log-group:/aws/route53/*"]

#     principals {
#       identifiers = ["route53.amazonaws.com"]
#       type        = "Service"
#     }
#   }
# }

# resource "aws_cloudwatch_log_resource_policy" "route53-query-logging-policy" {
#   provider = aws.sso
#   policy_document = data.aws_iam_policy_document.route53-query-logging-policy.json
#   policy_name     = "route53-query-logging-policy"
# }

# resource "aws_route53_query_log" "frankie_route53_log" {
#   count             = length(var.env_domains)
#   depends_on = [aws_cloudwatch_log_resource_policy.route53-query-logging-policy, aws_cloudwatch_log_group.aws_route53_frankie_log_group, aws_route53_zone.env]

#   cloudwatch_log_group_arn = aws_cloudwatch_log_group.aws_route53_frankie_log_group[count.index].arn
#   zone_id                  = aws_route53_zone.env[count.index].zone_id
# }





# resource "aws_cloudwatch_log_group" "aws_route53_resolver_log_group" {
#   name              = "/aws/route53/resolver-query-log"
#   retention_in_days = 30  
# }

# data "aws_iam_policy_document" "route53-query-resolver-logging-policy-document" {
#   statement {
#     actions = [
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#     ]

#     resources = [aws_cloudwatch_log_group.aws_route53_resolver_log_group.arn]

#     principals {
#       identifiers = ["delivery.logs.amazonaws.com"]
#       type        = "Service"
#     }
#   }
# }

# resource "aws_cloudwatch_log_resource_policy" "route53-query-resolver-logging-policy" {
#   policy_document = data.aws_iam_policy_document.route53-query-resolver-logging-policy-document.json
#   policy_name     = "route53-query-resolver-logging-policy"
# }

# resource "aws_route53_resolver_query_log_config" "resolve-config" {
#   name            = "resolver-example"
#   destination_arn = aws_cloudwatch_log_group.aws_route53_resolver_log_group.arn
# }

# resource "aws_route53_resolver_query_log_config_association" "resolve-config-assoc" {
#   resolver_query_log_config_id = aws_route53_resolver_query_log_config.resolve-config.id
#   resource_id                  = module.vpc.vpc_id
# }