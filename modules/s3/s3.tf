resource "aws_s3_bucket" "my_bucket" {
  count  = var.enable_s3 ? 1 : 0
  bucket = "My S3 Bucket"
}

resource "aws_s3_bucket_policy" "my_bucket_policy" {
  count   = var.enable_s3 ? 1 : 0
  bucket  = aws_s3_bucket.my_bucket[0].bucket
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Action   = "s3:PutObject",
        Resource = "${aws_s3_bucket.my_bucket[0].arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "s3_website" {
  count = var.enable_s3 && var.enable_website_configuration ? 1 : 0
  bucket = aws_s3_bucket.my_bucket[0].id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_iam_role" "s3_put_object_role" {
  count  = var.enable_s3 ? 1 : 0
  name = "My-S3-Bucket-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_put_object_policy" {
  count  = var.enable_s3 ? 1 : 0
  name        = "s3-putobject-policy"
  description = "Allows PutObject in a specific S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:PutObject",
        Resource = "${aws_s3_bucket.my_bucket[0].arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_put_object_attachment" {
  count  = var.enable_s3 ? 1 : 0
  role       = aws_iam_role.s3_put_object_role[0].name
  policy_arn = aws_iam_policy.s3_put_object_policy[0].arn
}
