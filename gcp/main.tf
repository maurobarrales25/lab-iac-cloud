locals {
  name = "${var.prefix}-${var.environment}"

  # En GCP los labels van en minúsculas
  labels = {
    environment  = var.environment
    owner        = lower(var.owner)
    "managed-by" = "iac"
    course       = "ucu-cloud"
    lab          = "v2"
  }

  user_data = templatefile("${path.module}/../shared/web.sh.tftpl", {
    mensaje     = var.mensaje
    environment = var.environment
    cloud       = "Google Cloud"
    bucket      = google_storage_bucket.this.name
    owner       = var.owner
  })
}
