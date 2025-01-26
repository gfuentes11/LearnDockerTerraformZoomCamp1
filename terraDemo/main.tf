terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "zoomcamp1-terraform"
  region  = "us-east4-a"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "zoomcamp1-terraform-bucket"
  location      = "US"
  force_destroy = true


  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}