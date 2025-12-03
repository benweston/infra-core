resource "digitalocean_project_resources" "terraform_state_bucket_assignment" {
  project = digitalocean_project.infra_core.id

  resources = [
    digitalocean_spaces_bucket.terraform_state.urn
  ]
}
