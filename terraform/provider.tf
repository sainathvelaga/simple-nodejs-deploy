terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.46"
    }
  }

  backend "s3" {
    bucket         = "state-tf-projects"
    key            = "practice build and deploy"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    encrypt        = true
    
  }
}




#provide authentication here
provider "aws" {
  region = "us-east-1"
}