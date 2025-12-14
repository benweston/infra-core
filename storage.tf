resource "google_storage_bucket" "terraform_state" {
  name          = "tfstate-${random_integer.suffix.result}"
  location      = "EUROPE-WEST2"
  project       = google_project.infra_core.project_id
  storage_class = "STANDARD"

  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      days_since_noncurrent_time = 90

      num_newer_versions = 5
    }
  }

  lifecycle_rule {
    action {
      type = "AbortIncompleteMultipartUpload"
    }
    condition {
      age = 7
    }
  }

  hierarchical_namespace { enabled = false }

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  labels = {
    service    = "infra-core"
    data_class = "restricted"
  }
}
