output "spaces_object_storage_bucket_name" {
  description = "The name of the bucket."
  value       = digitalocean_spaces_bucket.terraform_state.name
}

output "spaces_object_storage_console" {
  description = "Link to view the bucket in the DigitalOcean Spaces Console"
  value       = "https://cloud.digitalocean.com/spaces/${digitalocean_spaces_bucket.terraform_state.name}"
}

output "bucket_urn" {
  description = "URN of the Spaces bucket"
  value       = digitalocean_spaces_bucket.terraform_state.urn
}
