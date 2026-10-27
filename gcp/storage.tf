resource "random_id" "suffix" {
  byte_length = 3
}

resource "google_storage_bucket" "this" {
  name                        = "${local.name}-${random_id.suffix.hex}"
  location                    = "US"
  force_destroy               = true # solo para laboratorio
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket_object" "evidencia" {
  name    = "evidencia.txt"
  bucket  = google_storage_bucket.this.name
  content = "Creado por IaC | owner=${var.owner} | env=${var.environment}\n"
}
