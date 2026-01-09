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
    "infra-core"          = []                       # Provisioner, not consumer -> doesn't require VPCs.
    "infra-cicd"          = []                       # GitHub Actions shared library -> doesn't require VPCs.
    "infra-observability" = ["prod"]                 # Requires an environment for deploying Droplets (Prometheus, etc.,).
    "infra-security"      = []                       # Shared policies -> doesn't require VPCs.
    "infra-sandbox"       = ["dev"]                  # Development environment for creating short-lived resources.
    "app-portfolio"       = ["dev", "stage", "prod"] # Application workload.
  }
}

module "networking" {
  source               = "../../modules/networking"
  platform_cidr        = local.platform_cidr
  region               = local.region
  projects             = local.projects
  project_enabled_envs = { for k, v in local.project_enabled_envs : k => toset(v) }
}
