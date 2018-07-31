output "name" {
  description = "Name of SQS"
  value       = "${length(aws_sqs_queue.this.*.name) > 0 ? element(concat(aws_sqs_queue.this.*.name, list("")), 0) : element(concat(aws_sqs_queue.redrive.*.name, list("")), 0)}"
}

output "send_policy_arn" {
  value       = "${aws_iam_policy.send.arn}"
  description = "ARN of Send policy of SQS"
}

output "recieve_policy_arn" {
  value       = "${aws_iam_policy.recieve.arn}"
  description = "ARN of Recieve policy of SQS"
}

output "url" {
  description = "URL of SQS"
  value       = "${length(aws_sqs_queue.this.*.id) > 0 ? element(concat(aws_sqs_queue.this.*.id, list("")), 0) : element(concat(aws_sqs_queue.redrive.*.id, list("")), 0)}"
}
