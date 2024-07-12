terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
  access_key       = "" ##user aws-test creds
  secret_key       = ""
}


resource "aws_instance" "example" {
  count = 3

  ami           = "ami-123456"
  instance_type = "t2.micro"

  tags = {
    Name = "example-${count.index}"
  }
}

