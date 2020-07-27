# resource "google_compute_instance" "vm_control" {
#   name         = "ans-control"
#   machine_type = "f1-micro"

#   boot_disk {
#     initialize_params {
#       image = "centos-cloud/centos-8"
#     }
#   }

#   network_interface {
#     network = google_compute_network.vpc_network.name
#     access_config {
#     }
#   }

#   metadata_startup_script = "curl -s https://raw.githubusercontent.com/de-py/Terraform-Demo/master/ans.sh > /home/ans.sh"

#   tags = ["controller"]
# }