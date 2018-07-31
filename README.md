Terraform AWS SQS module
========================

Create a AWS SQS Queue with Death Letter Queue

Usage example
-------------

```HCL
module "queue" {
  source  = "Aplyca/s3/aws"

  name    = "MyQueue"
  description = "My SQS AWS Queue"
  retention = 1209600
  wait_time = 20
  send_roles = ["MySendRole1", "MySendRole2"]
  recieve_roles = ["MyRecieveRole"]
  max_recieve_count = 3
  tags {
    App = "MyApp"
    Environment = "Prod"
  }
}
```