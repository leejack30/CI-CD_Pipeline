terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-bucket-basicweb"
    key            = "web-cicd/terraform.tfstate"
    region         = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"

}



