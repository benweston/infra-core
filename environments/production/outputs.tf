output "project_id" {
  description = "The unique ID of the created project."
  value       = digitalocean_project.infra_core.id
}

output "project_console_url" {
  description = "Link to the Project Dashboard in Google Cloud Console."
  value       = "https://cloud.digitalocean.com/projects/${digitalocean_project.infra_core.id}/"
}

output "spaces_object_storage_bucket_name" {
  description = "The name of the bucket."
  value       = module.state_storage.spaces_object_storage_bucket_name
}

output "spaces_object_storage_console" {
  description = "Link to view the bucket in the DigitalOcean Spaces Console"
  value       = module.state_storage.spaces_object_storage_console
}
