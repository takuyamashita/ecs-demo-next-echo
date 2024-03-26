terraform {

  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Project     = "ecs-demo-next-echo"
      Environment = "dev"
    }
  }
}
