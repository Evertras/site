resource "aws_iam_user" "site_sync" {
  name = "${local.prefix}-site-sync"
}

resource "aws_iam_access_key" "site_sync" {
  user = aws_iam_user.site_sync.name
}

resource "aws_iam_user_policy" "site_sync" {
  user = aws_iam_user.site_sync.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:DeleteObject",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListObject",
          "s3:PutObject"
        ]
        Effect = "Allow"
        Resource = [
          aws_s3_bucket.site.arn,
          "${aws_s3_bucket.site.arn}/*"
        ]
      },
    ]
  })
}
