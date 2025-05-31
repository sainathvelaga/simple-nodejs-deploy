terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.46"
      bucket_name = "state-tf-projects"
      table_name  = "terraform-state-locks"
      region      = "us-east-1"
    }
  }
}




#provide authentication here
provider "aws" {
  region = "us-east-1"
}