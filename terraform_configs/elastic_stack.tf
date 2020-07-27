resource "google_compute_instance" "vm_elastic" {
  name         = "elastic"
  machine_type = "n1-standard-1"

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


  tags = ["elastic", "linux"]
}

resource "google_compute_instance" "vm_logstash" {
  name         = "logstash"
  machine_type = "n1-standard-1"

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


  tags = ["logstash", "linux"]
}

resource "google_compute_instance" "vm_kibana" {
  name         = "kibana"
  machine_type = "n1-standard-1"

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

  tags = ["kibana", "linux"]
}