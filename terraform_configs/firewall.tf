resource "google_compute_firewall" "default" {
  name    = "ssh-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }



  target_tags = ["controller", "vault", "ca", "linux"]

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
    ports    = ["5986","5985"]
  }

  source_tags = ["controller"]


  target_tags = ["dc"]

}

resource "google_compute_firewall" "default-35" {
  name    = "winrm-ans-firewall2"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "icmp"

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

resource "google_compute_firewall" "default-5" {
  name    = "logstash-port"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "tcp"
    ports    = ["9600"]
  }

  source_tags = ["windows"]


  target_tags = ["logstash"]

}

resource "google_compute_firewall" "default-6" {
  name    = "elasticsearch-port"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "tcp"
    ports    = ["9200"]
  }

  source_tags = ["kibana", "logstash"]


  target_tags = ["elastic"]

}

resource "google_compute_firewall" "default-7" {
  name    = "kibana-port"
  network = google_compute_network.vpc_network.name


  allow {
    protocol = "tcp"
    ports    = ["5601"]
  }

  # source_tags = [""]
  source_ranges = ["0.0.0.0/0"]

  target_tags = ["kibana"]

}