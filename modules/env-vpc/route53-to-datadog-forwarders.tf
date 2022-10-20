# resource "aws_lambda_permission" "allow_cloudwatch_for_apigw" {
#     count = length(var.env_domains)
#     action = "lambda:InvokeFunction"
#     function_name = "arn:aws:lambda:ap-southeast-2:516161102907:function:test"
#     principal   = "logs.us-east-1.amazonaws.com"
#     source_arn = "${aws_cloudwatch_log_group.aws_route53_frankie_log_group[count.index].arn}"
# }

# resource "aws_cloudwatch_log_subscription_filter" "apiqw_log_filter_cloudwatch_trigger" {
#     provider = aws.sso
#     depends_on      = ["aws_lambda_permission.allow_cloudwatch_for_apigw"]
#     count = length(var.env_domains)
#     name            = "apiGW-${var.env_domains[count.index]}"
#     log_group_name  = "/aws/route53/${var.env_domains[count.index]}"
#     filter_pattern  = ""
#     destination_arn = "arn:aws:lambda:ap-southeast-2:516161102907:function:test"
# }