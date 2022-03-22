#### Basic Information ####
  
# Provider Information
provider "aws" {
  region = var.region
}

terraform {
  # Library 버전
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.20"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }

  # Terraform 버전
  required_version = ">= 0.13"

  # State 저장용 S3 Backend 구성
  backend "s3" {
    bucket = "s3-jihyun-terraform-state"
    key    = "aws-an2/jenkinsdemo/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "table-jihyun-terraform-lock"
    encrypt = true
  }
}

#### Remote State Data Source ####
data "aws_availability_zones" "all" {}