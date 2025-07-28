terraform {
  backend "s3" {
    bucket = "fls-test-terraform-state"
    key    = "devel/terraform.tfstate"
    region = "us-east-1"
  }
}