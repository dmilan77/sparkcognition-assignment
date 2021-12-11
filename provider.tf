terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
terraform {
  backend "s3" {
    bucket = "tf-state-dmilan"
    key    = "sparkrecgnition"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}