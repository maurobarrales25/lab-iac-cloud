output "web_url" {
  value = "http://${aws_instance.web.public_ip}"
}

output "vm_id" {
  value = aws_instance.web.id
}

output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "vpc_id" {
  value = aws_vpc.this.id
}
