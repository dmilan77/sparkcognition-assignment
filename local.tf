locals {
  name   = var.generalname
  region = "us-east-1"

  user_data = <<-EOT
  #!/bin/bash
  echo "Hello Terraform!"
  yum update -y
  yum install -y httpd
  systemctl start httpd
  systemctl enable httpd
  EOT

  tags = [
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
    {
      key                 = "foo"
      value               = "something"
      propagate_at_launch = true
    },
  ]

  tags_as_map = {
    Owner       = "user"
    Environment = "dev"
  }

}