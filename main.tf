resource "google_project" "infra_core" {
  name            = "Infra - Core"
  project_id      = "infra-core-${random_integer.suffix.result}"
  billing_account = var.billing_account_id
  deletion_policy = "DELETE"
}

resource "google_project_service" "enabled_apis" {
  for_each = toset([
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "storage.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "cloudbilling.googleapis.com"
  ])

  service            = each.key
  project            = google_project.infra_core.project_id
  disable_on_destroy = false
}
