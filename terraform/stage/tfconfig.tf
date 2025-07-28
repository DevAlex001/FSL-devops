terraform {
  backend "s3" {
    bucket = "fls-test-terraform-state"
    key    = "stage/terraform.tfstate"
    region = "us-east-1"
  }
}