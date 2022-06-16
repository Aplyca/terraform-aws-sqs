variable "name" {
  description = "Name prefix for all CloudWatch Logs resources"
  default     = "App"
}

variable "retention" {
  description = "Message retention in seconds"
  default     = 0
}

variable "wait_time" {
  description = "Message recieve wait time in seconds"
  default     = 0
}

variable "tags" {
  type        = map
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "recieve_permissions" {
  default = [
    "sqs:DeleteMessage",
    "sqs:ReceiveMessage",
    "sqs:GetQueueAttributes"
  ]

  type        = list
  description = "Recieve permissions granted to assumed role"
}

variable "send_permissions" {
  default = [
    "sqs:PurgeQueue",
    "sqs:SendMessage",
    "sqs:SendMessageBatch",
    "sqs:SetQueueAttributes"
  ]

  type        = list
  description = "Send permissions granted to assumed role"
}

variable "description" {
  description = "Description of policy"
  default     = ""
}

variable "recieve_roles" {
  description = "Recieve permissions roles name"
  default     = []
}

variable "send_roles" {
  description = "Write roles name"
  default     = []
}

variable "max_recieve_count" {
  description = "Max recieve count for Dead-Letter queue"
  default     = 0
}
