data "archive_file" "zip_the_python_code" {
  count = var.enable_lambda ? 1 : 0
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/hello.zip"
}
