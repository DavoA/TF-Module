output "bucket_name" {
  value = var.enable_s3 ? aws_s3_bucket.my_bucket[0].bucket : null
}

output "bucket_domain_name" {
  value = var.enable_s3 ? aws_s3_bucket.my_bucket[0].bucket_domain_name : null
}

output "bucket_id" {
  value = var.enable_s3 ? aws_s3_bucket.my_bucket[0].id : null
}
