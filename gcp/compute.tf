resource "google_compute_instance" "web" {
  name                    = "${local.name}-vm"
  machine_type            = var.machine_type
  zone                    = var.zone
  tags                    = ["web"]
  metadata_startup_script = local.user_data

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.web.id

    # Bloque vacío = IP pública efímera
    access_config {}
  }
}
