resource "digitalocean_project" "infra_core" {
  name        = "infra-core"
  description = "Core infrastructure, remote state, global networking, and shared foundational cloud resources."
  purpose     = "Operational / Developer tooling"
  environment = var.env
  is_default  = false
}

module "state_storage" {
  source = "../../modules/state_storage"
  region = var.region
}

resource "digitalocean_project_resources" "infra_core" {
  project = digitalocean_project.infra_core.id

  resources = [
    module.state_storage.bucket_urn,
  ]
}
