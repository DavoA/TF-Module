resource "aws_s3_bucket" "my_bucket" {
  count  = var.enable_s3 ? 1 : 0
  bucket = var.s3_bucket_name
  dynamic "website" {
    for_each = var.enable_website_configuration ? ["enabled"] : []
    content {
      index_document = var.s3_html_file
    }
  }
}

resource "aws_s3_bucket_object" "s3_object" {
  count  = var.enable_s3 && var.enable_s3_object && var.enable_website_configuration == false ? 1 : 0
  bucket = aws_s3_bucket.my_bucket[0].bucket
  key    = var.s3_bucket_object_key
  source = var.s3_file_path
}

resource "aws_iam_role" "s3_put_object_role" {
  count = var.enable_s3 ? 1 : 0
  name  = var.s3_role_name
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
  count = var.enable_s3 ? 1 : 0
  name  = var.s3_policy_name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:PutObject","s3:GetObject"]
        Resource = "${aws_s3_bucket.my_bucket[0].arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_put_object_attachment" {
  count      = var.enable_s3 ? 1 : 0
  role       = aws_iam_role.s3_put_object_role[0].name
  policy_arn = aws_iam_policy.s3_put_object_policy[0].arn
}
