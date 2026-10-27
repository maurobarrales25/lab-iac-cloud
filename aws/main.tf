locals {
  name = "${var.prefix}-${var.environment}"

  tags = {
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "IaC"
    Course      = "UCU-Cloud"
    Lab         = "v2"
  }

  user_data = templatefile("${path.module}/../shared/web.sh.tftpl", {
    mensaje     = var.mensaje
    environment = var.environment
    cloud       = "AWS"
    bucket      = aws_s3_bucket.this.bucket
    owner       = var.owner
  })
}
