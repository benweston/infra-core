terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.13.0"
    }
  }
}

provider "google" {
  region = var.gcp_region

  default_labels = {
    env        = var.env
    managed_by = "terraform"
    repo       = "infra-core"
  }
}
