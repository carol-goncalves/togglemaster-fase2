resource "aws_sqs_queue" "evaluation_events" {
  name = "togglemaster-evaluation-events"

  visibility_timeout_seconds = 60
  message_retention_seconds  = 345600
  receive_wait_time_seconds  = 20

  sqs_managed_sse_enabled = true

  tags = {
    Name    = "togglemaster-evaluation-events"
    Project = "ToggleMaster"
  }
}
