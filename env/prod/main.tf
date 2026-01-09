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

locals {
  platform_cidr = "10.64.0.0/12"
  region        = "lon1"

  projects = {
    "infra-core"          = 0
    "infra-cicd"          = 1
    "infra-observability" = 2
    "infra-security"      = 3
    "infra-sandbox"       = 4
    # infra-* reserved = 5-9
    "app-portfolio" = 10
    # app-* reserved = 11-15
  }

  project_enabled_envs = {
    "infra-core"          = []
    "infra-cicd"          = ["dev", "stage", "prod"]
    "infra-observability" = ["dev", "stage", "prod"]
    "infra-security"      = ["dev", "stage", "prod"]
    "infra-sandbox"       = ["dev"]
    "app-portfolio"       = ["dev", "stage", "prod"]
  }
}

module "networking" {
  source               = "../../modules/networking"
  platform_cidr        = local.platform_cidr
  region               = local.region
  projects             = local.projects
  project_enabled_envs = { for k, v in local.project_enabled_envs : k => toset(v) }
}
