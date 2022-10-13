resource "aws_cloudwatch_event_rule" "guardduty_events" {
  name        = "guardduty-events"
  description = "Guard duty findings"

  event_pattern = jsonencode({
    "source" : ["aws.guardduty"],
    "detail-type" : ["GuardDuty Finding"]
  })
}

resource "aws_cloudwatch_event_target" "guardduty_rule_target" {
  target_id = "guarddutyrule"
  arn       = "arn:aws:lambda:ap-southeast-2:516161102907:function:WebappLambda"
  rule      = "${aws_cloudwatch_event_rule.guardduty_events.name}"
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = "WebappLambda"
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.guardduty_events.arn
}