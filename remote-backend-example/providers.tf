# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "5.31.0"
#     }
#   }
# }

provider "aws" {
  # Configuration options
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}