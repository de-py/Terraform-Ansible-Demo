resource "google_compute_instance" "vm_dc" {
  name         = "domain-control"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2019"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }


  tags = ["dc", "managed", "windows"]
}