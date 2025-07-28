terraform {
  backend "s3" {
    bucket = "fls-test-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}