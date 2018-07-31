data "aws_iam_policy_document" "recieve" {
  statement {
    actions = [
      "${var.recieve_permissions}"
    ]

    resources = [
      "${length(aws_sqs_queue.this.*.arn) > 0 ? element(concat(aws_sqs_queue.this.*.arn, list("")), 0) : element(concat(aws_sqs_queue.redrive.*.arn, list("")), 0)}",
    ]
  }
}

data "aws_iam_policy_document" "send" {
  statement {
    actions = [
      "${var.send_permissions}"
    ]

    resources = [
      "${length(aws_sqs_queue.this.*.arn) > 0 ? element(concat(aws_sqs_queue.this.*.arn, list("")), 0) : element(concat(aws_sqs_queue.redrive.*.arn, list("")), 0)}",
    ]
  }
}

data "template_file" "dead-letter" {
  count = "${var.max_recieve_count > 0 ? 1 : 0}"
  template = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.deadletter.arn}\",\"maxReceiveCount\":${var.max_recieve_count}}"
}
