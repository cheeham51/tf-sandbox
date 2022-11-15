resource "aws_sqs_queue" "events" {
  name = "event-logging-service-queue-dev"

  # seems wrong...
  visibility_timeout_seconds = 60 * 5
  delay_seconds              = 0
  receive_wait_time_seconds  = 20
  message_retention_seconds  = 60 * 60 * 24 * 4

}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  count            = "${var.lambda_function == "" ? 1 : 0}"
  event_source_arn = "${aws_sqs_queue.events.arn}"
  enabled          = true
  function_name    = "arn:aws:lambda:ap-southeast-2:516161102907:function:test"
  batch_size       = 10
  maximum_batching_window_in_seconds = 20
}