resource "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.environment}-fls-s3-logs-bucket-test"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.logs_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.logs_bucket.id
  acl    = "log-delivery-write"
}