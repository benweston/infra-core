output "network_plan" {
  description = "Human-readable plan: platform -> project -> env CIDRs, plus VPC naming. (No resource IDs.)"
  value = {
    platform_cidr = var.platform_cidr
    region        = var.region
    projects = {
      for project, p_idx in var.projects :
      project => {
        index = p_idx
        cidr  = local.project_cidrs[project]
        envs = {
          for env, e_idx in var.envs :
          env => {
            index    = e_idx
            cidr     = local.env_cidrs[project][env]
            vpc_name = trim(join("-", compact([var.name_prefix, project, env])), "-")
          }
        }
      }
    }
  }
}

output "vpcs" {
  description = "Provisioned VPCs keyed by 'project/env' with IDs and CIDRs."
  value = {
    for key, vpc in digitalocean_vpc.this :
    key => {
      id       = vpc.id
      urn      = vpc.urn
      name     = vpc.name
      region   = vpc.region
      ip_range = vpc.ip_range
    }
  }
}

output "vpc_ids" {
  description = "Provisioned VPC IDs keyed by 'project/env' (only enabled_envs are created)."
  value       = { for k, v in digitalocean_vpc.this : k => v.id }
}

output "env_cidrs" {
  description = "Convenience map: project -> env -> cidr."
  value       = local.env_cidrs
}

output "enabled_envs_by_project" {
  description = "Effective provisioning policy per project (used to create VPCs)."
  value       = local.enabled_envs_by_project
}
