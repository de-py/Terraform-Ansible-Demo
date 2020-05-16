
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

  metadata_startup_script = "curl -s https://raw.githubusercontent.com/de-py/Terraform-Demo/master/ans.sh > /home/ans.sh"

  tags = ["controller"]
}

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

  metadata_startup_script = "curl -s https://raw.githubusercontent.com/de-py/Terraform-Demo/master/ca/root-ca.conf > /home/root-ca.conf;
                             curl -s raw.githubusercontent.com/de-py/Terraform-Demo/master/ca/signing-ca.conf > /home/signing-ca.conf;
                             curl -s raw.githubusercontent.com/de-py/Terraform-Demo/master/ca/pki-setup.sh > /home/pki-setup.sh"

  tags = ["ca"]
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



  target_tags = ["controller", "vault", "ca"]

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

resource "google_compute_firewall" "default-4" {
  name    = "vault-ldap"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "tcp"
    ports    = ["636"]
  }

  source_tags = ["vault"]


  target_tags = ["dc"]

}