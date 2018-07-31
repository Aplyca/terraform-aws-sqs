locals {
  id = "${replace(var.name, " ", "-")}"
}

resource "aws_sqs_queue" "deadletter" {
  count = "${var.max_recieve_count > 0 ? 1 : 0}"
  name = "${local.id}-Dead-Letter"
  message_retention_seconds = "${var.retention}"  
  tags = "${var.tags}"
}

resource "aws_sqs_queue" "this" {
  count = "${var.max_recieve_count == 0 ? 1 : 0}"
  name = "${local.id}"
  message_retention_seconds = "${var.retention}"
  receive_wait_time_seconds = "${var.wait_time}"
  tags = "${var.tags}"
}

resource "aws_sqs_queue" "redrive" {
  count = "${var.max_recieve_count > 0 ? 1 : 0}"
  name = "${local.id}"
  message_retention_seconds = "${var.retention}"
  receive_wait_time_seconds = "${var.wait_time}"
  redrive_policy = "${element(data.template_file.dead-letter.*.rendered, count.index)}"
  tags = "${var.tags}"
}

resource "aws_iam_policy" "recieve" {
  name   = "${local.id}-SQS-Recieve"
  description = "${var.description} Read"
  policy = "${data.aws_iam_policy_document.recieve.json}"
}

resource "aws_iam_policy" "send" {
  name   = "${local.id}-SQS-Send"
  description = "${var.description} Send"
  policy = "${data.aws_iam_policy_document.send.json}"
}

# --------------------------------------------------------
# CREATE IAM Policy attachment
# --------------------------------------------------------
resource "aws_iam_role_policy_attachment" "recieve" {
  count = "${length(var.recieve_roles)}"
  role = "${element(var.recieve_roles, count.index)}"
  policy_arn = "${aws_iam_policy.recieve.arn}"
}

resource "aws_iam_role_policy_attachment" "send" {
  count = "${length(var.send_roles)}"
  role = "${element(var.send_roles, count.index)}"
  policy_arn = "${aws_iam_policy.send.arn}"
}
