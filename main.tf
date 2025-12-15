resource "google_folder" "platform" {
  display_name        = "fldr-platform"
  parent              = "organizations/${var.org_id}"
  deletion_protection = true
}

resource "google_folder" "apps" {
  display_name        = "fldr-apps"
  parent              = "organizations/${var.org_id}"
  deletion_protection = true
}

resource "google_folder" "sandbox" {
  display_name        = "fldr-sandbox"
  parent              = "organizations/${var.org_id}"
  deletion_protection = true
}

resource "google_project" "infra_core" {
  name            = "Infra - Core"
  project_id      = "infra-core-${random_integer.suffix.result}"
  folder_id       = google_folder.platform.name
  billing_account = var.billing_account_id
  deletion_policy = "PREVENT"
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

resource "time_sleep" "wait_for_apis" {
  create_duration = "60s"
  depends_on      = [google_project_service.enabled_apis]
}
