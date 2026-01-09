locals {
  project_cidrs = {
    for project, p_idx in var.projects :
    project => cidrsubnet(var.platform_cidr, 4, p_idx)
  }

  env_cidrs = {
    for project, project_cidr in local.project_cidrs :
    project => {
      for env, e_idx in var.envs :
      env => cidrsubnet(project_cidr, 4, e_idx)
    }
  }

  default_enabled_envs = toset([])

  enabled_envs_by_project = {
    for project, _ in var.projects :
    project => lookup(var.project_enabled_envs, project, local.default_enabled_envs)
  }

  vpc_matrix = merge([
    for project, env_map in local.env_cidrs : {
      for env, env_cidr in env_map :
      "${project}/${env}" => {
        project  = project
        env      = env
        cidr     = env_cidr
        region   = var.region
        vpc_name = trim(join("-", compact([var.name_prefix, project, env])), "-")
      }
      if contains(local.enabled_envs_by_project[project], env)
    }
  ]...)
}

resource "digitalocean_vpc" "this" {
  for_each = local.vpc_matrix

  name     = each.value.vpc_name
  region   = each.value.region
  ip_range = each.value.cidr

  description = "infra-core networking: ${each.value.project} ${each.value.env} (${each.value.cidr})"
}
