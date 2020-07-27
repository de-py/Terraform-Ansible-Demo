resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_project_default_network_tier" "default" {
  network_tier = "STANDARD"
}