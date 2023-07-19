resource "aws_s3_bucket" "site" {
  bucket = local.full_domain

  tags = local.tags
}

resource "aws_s3_bucket_ownership_controls" "site" {
  bucket = aws_s3_bucket.site.id

  rule {
    # Allows ACLs to be applied
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "site_public_read" {
  bucket = aws_s3_bucket.site.id

  acl = "public-read"

  depends_on = [aws_s3_bucket_ownership_controls.site]
}

resource "aws_s3_bucket_policy" "site_public_read_policy" {
  bucket = aws_s3_bucket.site.id

  policy = data.aws_iam_policy_document.site_policy.json
}

data "aws_iam_policy_document" "site_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.site.bucket}/*"
    ]
  }
}
