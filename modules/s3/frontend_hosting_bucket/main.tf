
resource "aws_s3_bucket" "npi_frontend_hosting" {
  bucket = "${var.project_name}-${var.environment}-frontend-hosting"
}
resource "aws_s3_bucket_website_configuration" "npi_frontend_hosting_website" {
  bucket = aws_s3_bucket.npi_frontend_hosting.bucket
  index_document {
    suffix = "index.html"
  }
}
resource "aws_s3_bucket_ownership_controls" "npi_frontend_hosting_ownership_controls" {
  bucket = aws_s3_bucket.npi_frontend_hosting.id

  rule {
    object_ownership = "ObjectWriter"
  }
}
resource "aws_s3_bucket_acl" "npi_frontend_hosting_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.npi_frontend_hosting_ownership_controls]
  bucket     = aws_s3_bucket.npi_frontend_hosting.id
  acl        = "public-read"
}
resource "aws_s3_bucket_public_access_block" "npi_frontend_hosting_public_access_block" {
  bucket                  = aws_s3_bucket.npi_frontend_hosting.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "npi_frontend_hosting-policy" {
  bucket = aws_s3_bucket.npi_frontend_hosting.id
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicReadGetObject",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${aws_s3_bucket.npi_frontend_hosting.bucket}/*"]
    }
  ]
}
POLICY
  depends_on = [
    aws_s3_bucket_public_access_block.npi_frontend_hosting_public_access_block,
  ]
}
