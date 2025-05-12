terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "sp-tofu-state"
    key            = "state/dev.tfstate"
    region         = "us-east-1"
    dynamodb_table = "sp-tofu-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "sp-tofu-bucket"
  force_destroy = true

  tags = {
    Name        = "ExampleBucket"
    Environment = "Dev"
  }
}
