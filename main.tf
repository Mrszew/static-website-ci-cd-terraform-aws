provider "aws" {
  region = "us-east-1"
}

# Tworzenie S3 bucket
resource "aws_s3_bucket" "website_bucket" {
  bucket = "marcel-xyz-demo-website"

  tags = {
    Name = "XYZ Demo Site"
  }
}

# Konfiguracja statycznej strony w S3
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Polityka publicznego dostępu do S3
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id

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

# Tworzenie CloudFront
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
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_100"

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "website_url" {
  value = aws_cloudfront_distribution.cdn_distribution.domain_name
}
