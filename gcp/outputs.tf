output "web_url" {
  value = "http://${google_compute_instance.web.network_interface[0].access_config[0].nat_ip}"
}

output "vm_id" {
  value = google_compute_instance.web.id
}

output "bucket_name" {
  value = google_storage_bucket.this.name
}

output "network" {
  value = google_compute_network.this.name
}
