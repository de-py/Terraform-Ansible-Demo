
provider "google" {
  version = "3.5.0"

  credentials = file("tsec.json")

  project = "terraform-271222"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_project_default_network_tier" "default" {
  network_tier = "STANDARD"
}

resource "google_compute_instance" "vm_control" {
  name         = "ans-control"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
  tags = ["controller"]
}

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
  tags = ["dc", "managed"]
}

resource "google_compute_firewall" "default" {
  name    = "ssh-firewall"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "tcp"
    ports    = ["22"]
  }



  target_tags = ["controller"]

}


resource "google_compute_firewall" "default-2" {
  name    = "rdp-firewall"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }



  target_tags = ["dc"]

}

resource "google_compute_firewall" "default-3" {
  name    = "winrm-ans-firewall"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "tcp"
    ports    = ["5986"]
  }

  source_tags = ["controller"]


  target_tags = ["dc"]

}
