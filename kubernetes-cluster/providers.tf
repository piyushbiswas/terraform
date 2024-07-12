terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}


