provider "aws" {
  region = "us-east-1"
}

# Tworzenie S3 bucket dla production
resource "aws_s3_bucket" "website_bucket" {
  bucket = "marcel-xyz-demo-website"

  tags = {
    Name = "XYZ Demo Site"
    Environment = "Production"
    Project = "Static Website CI/CD"
  }
}

# Tworzenie S3 bucket dla development
resource "aws_s3_bucket" "website_bucket_dev" {
  bucket = "marcel-xyz-demo-website-dev"

  tags = {
    Name = "XYZ Demo Site Dev"
    Environment = "Development"
    Project = "Static Website CI/CD"
  }
}

# Wyłączenie blokowania publicznego dostępu dla production
resource "aws_s3_bucket_public_access_block" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Wyłączenie blokowania publicznego dostępu dla development
resource "aws_s3_bucket_public_access_block" "website_bucket_dev" {
  bucket = aws_s3_bucket.website_bucket_dev.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Szyfrowanie S3 dla production
resource "aws_s3_bucket_server_side_encryption_configuration" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Szyfrowanie S3 dla development
resource "aws_s3_bucket_server_side_encryption_configuration" "website_bucket_dev" {
  bucket = aws_s3_bucket.website_bucket_dev.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Versioning S3 dla production
resource "aws_s3_bucket_versioning" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Versioning S3 dla development
resource "aws_s3_bucket_versioning" "website_bucket_dev" {
  bucket = aws_s3_bucket.website_bucket_dev.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Object Lock dla production
resource "aws_s3_bucket_object_lock_configuration" "website_bucket" {
  bucket = aws_s3_bucket.website_bucket.id

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 1
    }
  }
}

# Object Lock dla development
resource "aws_s3_bucket_object_lock_configuration" "website_bucket_dev" {
  bucket = aws_s3_bucket.website_bucket_dev.id
  depends_on = [aws_s3_bucket_versioning.website_bucket_dev]

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 1
    }
  }
}

# Konfiguracja statycznej strony w S3 dla production
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Konfiguracja statycznej strony w S3 dla development
resource "aws_s3_bucket_website_configuration" "website_dev" {
  bucket = aws_s3_bucket.website_bucket_dev.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Polityka publicznego dostępu do S3 dla production
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.website_bucket]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
        Principal = "*"
      }
    ]
  })
}

# Polityka publicznego dostępu do S3 dla development
resource "aws_s3_bucket_policy" "bucket_policy_dev" {
  bucket = aws_s3_bucket.website_bucket_dev.id
  depends_on = [aws_s3_bucket_public_access_block.website_bucket_dev]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "s3:GetObject"
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.website_bucket_dev.arn}/*"
        Principal = "*"
      }
    ]
  })
}

# IAM Role dla read-only access
resource "aws_iam_role" "s3_readonly_role" {
  name = "s3-readonly-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "S3 Read-Only Role"
  }
}

# IAM Policy dla read-only access
resource "aws_iam_role_policy" "s3_readonly_policy" {
  name = "s3-readonly-policy"
  role = aws_iam_role.s3_readonly_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.website_bucket.arn,
          "${aws_s3_bucket.website_bucket.arn}/*"
        ]
      }
    ]
  })
}

# IAM Role dla read-write access
resource "aws_iam_role" "s3_readwrite_role" {
  name = "s3-readwrite-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "S3 Read-Write Role"
  }
}

# IAM Policy dla read-write access
resource "aws_iam_role_policy" "s3_readwrite_policy" {
  name = "s3-readwrite-policy"
  role = aws_iam_role.s3_readwrite_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.website_bucket.arn,
          "${aws_s3_bucket.website_bucket.arn}/*"
        ]
      }
    ]
  })
}

# Tworzenie CloudFront dla production
resource "aws_cloudfront_distribution" "cdn_distribution" {
  origin {
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id   = "S3-XYZ-Demo"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-XYZ-Demo"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  tags = {
    Environment = "Production"
    Project     = "Static Website CI/CD"
  }
}

# Tworzenie CloudFront dla development
resource "aws_cloudfront_distribution" "cdn_distribution_dev" {
  origin {
    domain_name = aws_s3_bucket.website_bucket_dev.bucket_regional_domain_name
    origin_id   = "S3-XYZ-Demo-Dev"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-XYZ-Demo-Dev"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 3600
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  tags = {
    Environment = "Development"
    Project     = "Static Website CI/CD"
  }
}

output "website_url" {
  value = aws_cloudfront_distribution.cdn_distribution.domain_name
}

output "website_url_dev" {
  value = aws_cloudfront_distribution.cdn_distribution_dev.domain_name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}

output "s3_bucket_name_dev" {
  value = aws_s3_bucket.website_bucket_dev.bucket
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.cdn_distribution.id
}

output "cloudfront_distribution_id_dev" {
  value = aws_cloudfront_distribution.cdn_distribution_dev.id
}
