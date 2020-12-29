resource "google_compute_instance" "vm_dc" {
  name         = "domain-control"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

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

  metadata = {
    serial-port-logging-enable = "TRUE"
    windows-keys = jsonencode(
      {
        email    = "dle.pyc@gmail.com"
        expireOn = "2021-04-14T01:37:19Z"
        exponent = "AQAB"
        modulus  = "wgsquN4IBNPqIUnu+h/5Za1kujb2YRhX1vCQVQAkBwnWigcCqOBVfRa5JoZfx6KIvEXjWqa77jPvlsxM4WPqnDIM2qiK36up3SKkYwFjff6F2ni/ry8vrwXCX3sGZ1hbIHlK0O012HpA3ISeEswVZmX2X67naOvJXfY5v0hGPWqCADao+xVxrmxsZD4IWnKl1UaZzI5lhAzr8fw6utHwx1EZ/MSgsEki6tujcZfN+GUDRnmJGQSnPTXmsf7Q4DKreTZk49cuyB3prV91S0x3DYjCUpSXrkVy1Ha5XicGD/q+ystuFsJnrrhbNXJbpSjM6sjo/aduAkZJl4FmOt0R7Q=="
        userName = "aduser"
      }
    )
  }



  tags = ["dc", "managed", "windows"]

}

data "google_compute_instance_serial_port" "serial" {
  instance = google_compute_instance.vm_dc.name
  zone     = google_compute_instance.vm_dc.zone
  port     = 4
}
output "serial_out" {
  value = data.google_compute_instance_serial_port.serial.contents
}

