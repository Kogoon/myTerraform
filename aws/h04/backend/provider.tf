terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  
  backend s3 {
    bucket         = "terraform-backend-kogoon" 
    key            = "terraform/global/terraform.tfstate" 
    region         = "ap-northeast-2"
    dynamodb_table = "terraform-tfstate-lock"
  }

}

provider "aws" {
  region = "ap-northeast-2"
}