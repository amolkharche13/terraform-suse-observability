terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.15.0"
    }
  }
}

provider "google" {
   project = "rancher-support-01"
  region  = var.region
}
