terraform {
  backend "s3" {
    bucket = "yusuf-aws-cicd-pipeline"
    encrypt = true
    key = "terraform.tfstate"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}