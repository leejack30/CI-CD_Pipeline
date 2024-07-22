terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.47.0"
    }
  }
  required_version = ">= 1.5.3"
}

provider "aws" {
  region = "ap-northeast-1"
}
