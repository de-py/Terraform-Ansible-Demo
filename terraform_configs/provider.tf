provider "google" {
  version = "3.5.0"

  #credentials = file("tsec.json")

  project = "terraform-271222"
  region  = "us-central1"
  zone    = "us-central1-c"
}