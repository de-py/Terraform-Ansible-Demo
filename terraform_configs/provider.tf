terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.51.0"
    }
  }
}



provider "google" {
  version = "3.51.0"

  #credentials = file("tsec.json")

  project = "terraform-271222"
  region  = "us-central1"
  zone    = "us-central1-c"
}
