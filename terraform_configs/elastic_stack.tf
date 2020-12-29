resource "google_compute_instance" "vm_elastic" {
  name         = "elastic"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }


  tags = ["elastic", "linux","elk"]
}

resource "google_compute_instance" "vm_logstash" {
  name         = "logstash"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }


  tags = ["logstash", "linux","elk"]
}

resource "google_compute_instance" "vm_kibana" {
  name         = "kibana"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  tags = ["kibana", "linux","elk"]
}

output "vm_elastic_ip" {
    value = concat(google_compute_instance.vm_elastic.*.network_interface.0.access_config.0.nat_ip,google_compute_instance.vm_elastic.tags.*)
}
output "vm_logstash_ip" {
    value = concat(google_compute_instance.vm_logstash.*.network_interface.0.access_config.0.nat_ip, google_compute_instance.vm_logstash.tags.*)
}
output "vm_kibana_ip" {
    value = concat(google_compute_instance.vm_kibana.*.network_interface.0.access_config.0.nat_ip, google_compute_instance.vm_kibana.tags.*)
}
