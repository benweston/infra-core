output "project_id" {
  description = "The unique ID of the created project"
  value       = google_project.infra_core.project_id
}

output "project_number" {
  description = "The numeric identifier of the project"
  value       = google_project.infra_core.number
}

output "project_console_url" {
  description = "Link to the Project Dashboard in Google Cloud Console"
  value       = "https://console.cloud.google.com/home/dashboard?project=${google_project.infra_core.project_id}"
}

output "tfstate_bucket_name" {
  description = "The specific name of the created bucket"
  value       = google_storage_bucket.terraform_state.name
}

output "tfstate_console_url" {
  description = "Link to view the Terraform State bucket in the Google Cloud Console"
  value       = "https://console.cloud.google.com/storage/browser/${google_storage_bucket.terraform_state.name}"
}
