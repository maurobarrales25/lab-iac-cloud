resource "google_compute_network" "this" {
  name                    = "${local.name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "web" {
  name          = "${local.name}-subnet-web"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.this.id
}

# Firewall: solo HTTP entrante hacia VMs con la etiqueta de red "web"
resource "google_compute_firewall" "http" {
  name          = "${local.name}-allow-http"
  network       = google_compute_network.this.id
  direction     = "INGRESS"
  source_ranges = [var.allowed_cidr]
  target_tags   = ["web"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}
