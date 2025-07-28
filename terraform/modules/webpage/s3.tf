resource "aws_s3_bucket" "fsl_bucket" {
  bucket = "${var.environment}-mybucket-test-fsl-bucket"

  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_bucket_ownership_controls" "fsl_bucket_ownership_controls" {
  bucket = aws_s3_bucket.fsl_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# resource "aws_s3_bucket" "example" {
#   bucket = "my-tf-test-bucket"
# }

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.fsl_bucket.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      aws_s3_bucket.fsl_bucket.arn,
      "${aws_s3_bucket.fsl_bucket.arn}/*",
    ]
  }
}