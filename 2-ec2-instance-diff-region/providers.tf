terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}


# Define the AWS providers for different regions
provider "aws" {
  alias      = "us_east_1"
  region     = "us-east-1"
  access_key = ""
  secret_key = ""

}

provider "aws" {
  alias      = "us_east_2"
  region     = "us-east-2"
  access_key = ""
  secret_key = ""

}


provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""

}
