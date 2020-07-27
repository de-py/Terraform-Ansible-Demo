resource "google_compute_instance" "vm_vault" {
  name         = "hash-vault"
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

  metadata_startup_script = "curl -s https://raw.githubusercontent.com/de-py/Terraform-Demo/master/vault_setup.sh > /home/vault_setup.sh"

  tags = ["vault"]
}


resource "google_compute_instance" "vm_pki_ca" {
  name         = "pki-ca"
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

  metadata_startup_script = "curl -s raw.githubusercontent.com/de-py/Terraform-Demo/master/ca/pki-setup.sh > /home/pki-setup.sh"

  tags = ["ca"]
}