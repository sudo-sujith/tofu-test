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
  bucket = "sp-tofu-s3"
  force_destroy = true

  tags = {
    Name        = "ExampleBucket"
    Environment = "Dev"
  }
}

resource "aws_organizations_account" "new_account" {
  name      = "tofu-test"
  email     = "test@tofu.com"
  role_name = "OrganizationAccountAccessRole"
  parent_id = "r-p5cy" # Replace with your OU ID
}

