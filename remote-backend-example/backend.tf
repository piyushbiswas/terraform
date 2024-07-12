terraform {
  backend "s3" {
    bucket         = "my-terraform-state-backup"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
