resource "aws_sqs_queue" "security_hub_findings_queue" {
  provider = aws.dev
  name = "security-hub-findings-queue"
  visibility_timeout_seconds = 800
}

resource "aws_sqs_queue_policy" "example" {
  provider = aws.dev
  queue_url = aws_sqs_queue.security_hub_findings_queue.url

  policy = jsonencode({
    Version = "2012-10-17",
    Id      = "example-ID",
    Statement = [
      {
        Sid       = "example-SID",
        Effect    = "Allow",
        Principal = {
          Service = "events.amazonaws.com"
        },
        Action    = [
          "sqs:SendMessage",
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        Resource  = aws_sqs_queue.security_hub_findings_queue.arn,
        Condition = {
          ArnLike = {
            "aws:SourceArn" = "arn:aws:events:ap-southeast-2:616625844834:rule/*"
          }
        }
      }
    ],
  })
}
